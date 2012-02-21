require 'optparse'

DEFAULT_CONVERT_BASE_DIR = "#{ENV['PWD']}"
DEFAULT_CLEAN_BASE_DIR   = "#{ENV['PWD']}/bvwack-back"
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 2 -strict experimental"
help_text                = "
Usage: bvwack <options>

Default action is equivalent to bvwack -n 2

Options:
    -b BASE_DIR, --base-dir BASE_DIR  Set BASE_DIR instead of /Volumes/thundar/media/video
    -d, --dry-run                     Do a dry run. Prints proposed commands to STDOUT.
    -c, --clean-up                    Instead of converting, move all converted files to /Volumes/thundar/media/converted/[old-path]
    -n #, --num-files #               Number of videos to batch.
    -l, --list_converted              Lists files that have been converted but not cleaned. Useful for vierifying successful conversion.

Notes: By default this will not work for you. You must change DEFAULT_CONVERT_BASE_DIR
       and DEFAULT_CLEAN_BASE_DIR to something that exists on your system. Do not let
       the clean dir be a subdirectory of base dir or you'll be sad. I have set the
       FFMPEG options to use only 2 threads. This allows me to use my laptop while
       converting things. If you just want to hog through video try setting -threads 0
       in FFMPEG_OPTS. Currently this only works on UNIX-like systems.

Requirements: ffmpeg and a libx264-slow.ffpreset (possibly in your ~/.ffmpeg/ directory or in your Cellar if you use brew.) Google is your friend.

Examples:
    bvwack -dw                             Shows proposed commands for 2 videos
    bvwack -w -b somedir/anotherdir -n 5   Converts 5 videos under somedir/anotherdir
    bvwack -c -n 10                        Moves 10 already converted mkv or avi files to /Volumes/thundar/medai/converted/[od-path]"

@converted_files     = { }
@not_converted_files = { }
@to_convert          = []


options       = { }
option_parser = OptionParser.new do |opts|
  opts.on("-d", "--dry-run") do
    options[:dry_run] = true
  end

  opts.on("-b BASE_DIR", "--base-dir BASE_DIR") do |base_dir|
    options[:base_dir] = base_dir
  end

  opts.on("-c", "--clean-up") do
    options[:clean_up] = true
  end

  opts.on("-n NUM_FILES", "--num-files NUM_FILES", Integer) do |num_files|
    options[:num_files] = num_files
  end

  opts.on("-h", "--help") do
    options[:help] = true
  end

  opts.on("-l", "--list-converted") do
    options[:list_converted] = true
  end

  opts.on("-w", "--wack") do
    options[:wack] = true
  end
end

def echo_base_dirs(options)
  if options[:base_dir]
    puts "\nOperating in #{ options[:base_dir]}"
    puts "I will create #{ options[:base_dir]}/bvwack-back to store converted files if you use clean-up.\n\n"
  else
    puts "\nOperating in #{DEFAULT_CONVERT_BASE_DIR}"
    puts "I will create #{ DEFAULT_CLEAN_BASE_DIR} to store converted files if you use clean-up.\n\n"
  end
end

def convert(path_to_file)
  if path_to_file.class == String
    `ffmpeg -i "#{path_to_file}" #{FFMPEG_OPTS} "#{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}"`
  end
end

def dry_run(path_to_file)
  if path_to_file.class == String
    puts "ffmpeg -i #{path_to_file} #{FFMPEG_OPTS} #{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}\n\n"
  end
end


def get_files(args)
  if args[0]
    args.each do |path|
      if File.file?(path)
        @paths << path
      else
        puts "#{path} is not a real file. Skipping. Try single-quoting the path if it is spacey or ugly."
      end
    end
  else
    puts "Specify the file(s) to convert: ./media/dir/dir/file1.mkv <'./media/dir/dir name/file(2).avi'>"
  end
end


def get_all_files(options)
  if options[:base_dir]
    base_dir = options[:base_dir]
  else
    base_dir = DEFAULT_CONVERT_BASE_DIR
  end
  Dir.chdir(base_dir)
  converted_files = Dir.glob(File.join("**", "*ipad.mp4"))
  converted_files.each do |i|
    if i.include?("bvwack-back")
      next
    else
      @converted_files[File.basename(i, ".ipad.mp4")] = i
    end
  end

  not_converted_files = Dir.glob(File.join("**", "*.{mkv,avi}"))
  not_converted_files.each do |i|
    if i.include?("bvwack-back")
      next
    else
      if File.basename(i).split(".").last == "mkv"
        @not_converted_files[File.basename(i, ".mkv")] = i
      elsif File.basename(i).split(".").last == "avi"
        @not_converted_files[File.basename(i, ".avi")] = i
      end
    end
  end
end

def get_unconverted_files(converted_files, not_converted_files)
  (not_converted_files.keys - converted_files.keys).each do |key|
    @to_convert << @not_converted_files[key]
  end
end

def clean_up(options)
  if options[:base_dir]
    clean_dir = "#{options[:base_dir]}/bvwack-back"
  else
    clean_dir = DEFAULT_CONVERT_BASE_DIR
  end
  if @to_clean.length > 0
    key      = @to_clean.pop
    filename = @not_converted_files[key]
    dirname  = File.dirname(@not_converted_files[key])
    `mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"`
  #else
  #  puts "No more files to clean. Hooray!"
  end
end

def dry_clean_up(options)
  if options[:base_dir]
    clean_dir = "#{options[:base_dir]}/bvwack-back"
  else
    clean_dir = DEFAULT_CONVERT_BASE_DIR
  end
  if @to_clean.length > 0
    key      = @to_clean.pop
    filename = @not_converted_files[key]
    dirname  = File.dirname(@not_converted_files[key])
    print "\n\ndirname: "
    p dirname
    print "\n\nclean_dir: "
    p clean_dir
    puts %Q{mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"\n\n}
  #else
  #  puts "No more files to clean. Hooray!"
  end
end

def list_converted
  begin
    while @to_clean
      key                = @to_clean.pop
      converted_filename = @converted_files[key]
      old_filename       = @not_converted_files[key]
      dirname            = File.dirname(@not_converted_files[key])
      puts "\nConverted file:\n"
      puts %Q{In Directory "#{dirname}"}
      p `ls -lh "#{converted_filename}"`
      p `ls -lh "#{old_filename}"`
      puts %Q{To test run:  open "#{converted_filename}"}
      puts "\n\n"
    end
  rescue
    puts("\nNothing to list")
  end
end

option_parser.parse!
puts options.inspect

if options[:num_files]
  limit = (options[:num_files] - 1).to_i
else
  limit = 2
end

case
  when options[:wack] == TRUE && options[:clean_up] == TRUE
    puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
  when options[:list_converted] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    list_converted
  when options[:dry_run] == TRUE && options[:clean_up] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..limit).each do
      dry_clean_up(options)
    end
  when options[:clean_up] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..limit).each do
      #puts "I would have run clean_up"
      clean_up(options)
    end
  when options[:dry_run] == TRUE && options[:wack] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..limit).each do |i|
      file = @to_convert[i]
      dry_run(file)
    end
  when options[:wack] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..limit).each do |i|
      file = @to_convert[i]
      #puts "I would have run convert(file)"
      convert(file)
    end
  else
    puts help_text
end

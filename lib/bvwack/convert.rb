require 'optparse'

DEFAULT_CONVERT_BASE_DIR = "/Volumes/thundar/media/video"
DEFAULT_CLEAN_BASE_DIR   = "/Volumes/thundar/media/converted"
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 2 -strict experimental"
help_text                = "
Usage: convertAll.rb <options>

Default action is equivalent to convertAll.rb -n 2

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
       in FFMPEG_OPTS.

Examples:
    convertAll.rb -d                             Shows proposed commands for 2 videos
    convertAll.rb -b somedir/anotherdir -n 5     Converts 5 videos under somedir/anotherdir
    convertAll.rb -c -n 10                       Moves 10 already converted mkv or avi files to /Volumes/thundar/medai/converted/[od-path]"

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
end

def convert(path_to_file)
  `ffmpeg -i #{path_to_file} #{FFMPEG_OPTS} #{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}`
end

def dry_run(path_to_file)
  puts "ffmpeg -i #{path_to_file} #{FFMPEG_OPTS} #{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}\n\n"
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

@converted_files     = { }
@not_converted_files = { }

def get_all_files(base_dir = DEFAULT_CONVERT_BASE_DIR)
  Dir.chdir(base_dir)
  converted_files = Dir.glob(File.join("**", "*ipad.mp4"))
  converted_files.each do |i|
    @converted_files[File.basename(i, ".ipad.mp4")] = i
  end
  not_converted_files = Dir.glob(File.join("**", "*.{mkv,avi}"))
  not_converted_files.each do |i|
    if File.basename(i).split(".").last == "mkv"
      @not_converted_files[File.basename(i, ".mkv")] = i
    elsif File.basename(i).split(".").last == "avi"
      @not_converted_files[File.basename(i, ".avi")] = i
    end
  end
end

@to_convert = []

def get_unconverted_files(converted_files, not_converted_files)
  (not_converted_files.keys - converted_files.keys).each do |key|
    @to_convert << @not_converted_files[key]
  end
end

def clean_up
  if @to_clean.length > 0
    key      = @to_clean.pop
    filename = @not_converted_files[key]
    dirname  = File.dirname(@not_converted_files[key])
    #puts %Q{mkdir -p "/Volumes/thundar/media/video/converted/#{dirname}" && mv "#{filename}" "/Volumes/thundar/media/video/converted/#{filename}"}
    #puts "This would mv #{@converted_files[key]} /Volumes/thundar/media/video/converted/#{@converted_files[key]}"
    `mkdir -p "#{DEFAULT_CLEAN_BASE_DIR}/#{dirname}" && mv "#{filename}" "#{DEFAULT_CLEAN_BASE_DIR}/#{filename}"`
  else
    puts "No more files to clean. Hooray!"
  end
end

def dry_clean_up
  if @to_clean.length > 0
    key      = @to_clean.pop
    filename = @not_converted_files[key]
    dirname  = File.dirname(@not_converted_files[key])
    puts %Q{mkdir -p "#{DEFAULT_CLEAN_BASE_DIR}/#{dirname}" && mv "#{filename}" "#{DEFAULT_CLEAN_BASE_DIR}/#{filename}"\n\n}
  else
    puts "No more files to clean. Hooray!"
  end
end

def list_converted
  while @to_clean
    #if @to_clean.length > 0
      key                = @to_clean.pop
      converted_filename = @converted_files[key]
      old_filename       = @not_converted_files[key]
      dirname            = File.dirname(@not_converted_files[key])
      puts "Converted file:\n"
      puts "in Directory #{dirname}"
      p `ls -lh #{converted_filename}`
      p `ls -lh #{old_filename}`
      puts %Q{To test run:  open "#{converted_filename}"}
      puts "\n\n"
    #end
  end
end


option_parser.parse!
puts options.inspect
if options[:base_dir]
  basedir = options[:base_dir]
  get_all_files(basedir)
else
  get_all_files
end

get_unconverted_files(@converted_files, @not_converted_files)
@to_clean = @not_converted_files.keys & @converted_files.keys

if options[:num_files]
  limit = (options[:num_files] - 1).to_i
else
  limit = 2
end

case
  when options[:list_converted] == TRUE
    list_converted
  when options[:help] == TRUE
    puts help_text
  else
    (0..limit).each do |i|
      file = @to_convert[i]
      if options[:dry_run] == TRUE
        if options[:clean_up] == TRUE
          dry_clean_up
        else
          dry_run(file)
        end
      else
        if options[:clean_up] == TRUE
          puts "I would have run clean_up"
          #clean_up
        else
          puts "I would have run convert(file)"
          #convert(file)
        end
      end
    end
end


=begin
if options[:help] != TRUE
  @to_clean = @not_converted_files.keys & @converted_files.keys
  (0..limit).each do |i|
    file = @to_convert[i]
    if options[:dry_run] == TRUE
      if options[:clean_up] == TRUE
        dry_clean_up
      else
        dry_run(file)
      end
    else
      if options[:clean_up] == TRUE
        #puts "I would have run clean_up"
        clean_up
      else
        #puts "I would have run convert(file)"
        convert(file)
      end
    end
  end
else
  puts help_text
end
=end

=begin
 automated idea:
recursivly search for all file in directory.
- add all .ipad.mp4 files to one array. (strip off path and .ipad.mp4 extension yielding bare file name)
- add all other video files to another array. (test all extensions for inclusion in supported file types array.)(strip off path and extension yielding bare file name)
-- subtract ipad.mp4 array from other array yielding array of files that have not been converted.
p Dir['**/*.*']
foo
ffmpeg -i Archer.S01E01.720p.BluRay.X264-REWARD.mkv -acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 0 -strict experimental Archer.S01E01.720p.BluRay.X264-REWARD.ipad.mp4
=end

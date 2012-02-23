require_relative 'help'
require_relative 'options'
require_relative 'lister'

DEFAULT_CONVERT_BASE_DIR = "#{ENV['PWD']}"
DEFAULT_CLEAN_BASE_DIR   = "#{ENV['PWD']}/bvwack-back"
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 2 -strict experimental"

@converted_files     = { }
@not_converted_files = { }
@to_convert          = []


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
    clean_dir = DEFAULT_CLEAN_BASE_DIR
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
    clean_dir = DEFAULT_CLEAN_BASE_DIR
  end
  if @to_clean.length > 0
    key      = @to_clean.pop
    filename = @not_converted_files[key]
    dirname  = File.dirname(@not_converted_files[key])
    puts %Q{mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"\n\n}
    #else
    #  puts "No more files to clean. Hooray!"
  end
end



options = GetOptions.new.put_options
p options

def set_limit(options)
  if options[:num_files]
    limit = (options[:num_files] - 1).to_i
  else
    limit = 2
  end
  limit
end

iteration_limit = set_limit(options)


case
  when options[:wack] == TRUE && options[:clean_up] == TRUE
    puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
  when options[:list_converted] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    #list_converted
    Lister.new(@to_clean, @converted_files, @not_converted_files).list_converted
  when options[:dry_run] == TRUE && options[:clean_up] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..iteration_limit).each do
      dry_clean_up(options)
    end
  when options[:clean_up] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..iteration_limit).each do
      #puts "I would have run clean_up"
      clean_up(options)
    end
  when options[:dry_run] == TRUE && options[:wack] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..iteration_limit).each do |i|
      file = @to_convert[i]
      dry_run(file)
    end
  when options[:wack] == TRUE
    get_all_files(options)
    get_unconverted_files(@converted_files, @not_converted_files)
    @to_clean = @not_converted_files.keys & @converted_files.keys
    echo_base_dirs(options)
    (0..iteration_limit).each do |i|
      file = @to_convert[i]
      #puts "I would have run convert(file)"
      convert(file)
    end
  else
    man = Help.new
    man.be_helpful
end

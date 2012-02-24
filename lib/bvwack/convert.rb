require_relative 'help'
require_relative 'options'
require_relative 'lister'
require_relative 'dryCleaner'
require_relative 'cleaner'
require_relative 'echobasedirs'
require_relative 'runner'
require_relative 'converter'

DEFAULT_CONVERT_BASE_DIR = "#{ENV['PWD']}"
DEFAULT_CLEAN_BASE_DIR   = "#{ENV['PWD']}/bvwack-back"
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 2 -strict experimental"

@converted_files     = { }
@not_converted_files = { }
@to_convert          = []

def dry_run(path_to_file)
  if path_to_file.class == String
    puts "ffmpeg -i #{path_to_file} #{FFMPEG_OPTS} #{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}\n\n"
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


def prep_operation(options)
  get_all_files(options)
  get_unconverted_files(@converted_files, @not_converted_files)
  @to_clean = @not_converted_files.keys & @converted_files.keys
end


def set_limit(options)
  if options[:num_files]
    limit = (options[:num_files] - 1).to_i
  else
    limit = 2
  end
  limit
end


options = GetOptions.new.put_options
p options
iteration_limit = set_limit(options)
prep_operation(options)


case
  when options[:wack] == TRUE && options[:clean_up] == TRUE
    puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
  when options[:list_converted] == TRUE
    prep_operation(options)
    #list_converted
    Lister.new(@to_clean, @converted_files, @not_converted_files).list_converted
  when options[:dry_run] == TRUE && options[:clean_up] == TRUE
    Runner.new(:dry_clean_up, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  when options[:clean_up] == TRUE
    Runner.new(:clean_up, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  #puts "I would have run clean_up"
  when options[:dry_run] == TRUE && options[:wack] == TRUE
    Runner.new(:dry_run, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  when options[:wack] == TRUE
    Runner.new(:wack, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  #puts "I would have run convert(file)"
  else
    man = Help.new
    man.be_helpful
end

class EchoBaseDirs
  def initialize(args)
    @options = args[:options]
  end

  def echo_base_dirs
    if options[:base_dir]
      puts "\nOperating in #{ options[:base_dir]}"
      puts "I will create #{ File.join(options[:base_dir], "bvwack-back")} to store converted files if you use clean-up.\n\n"
    else
      puts "\nOperating in #{DEFAULT_CONVERT_BASE_DIR}"
      puts "I will create #{ DEFAULT_CLEAN_BASE_DIR} to store converted files if you use clean-up.\n\n"
    end
  end

  def base_convert_dir
    if options[:base_dir]
      base_dir = options[:base_dir]
    else
      base_dir = DEFAULT_CONVERT_BASE_DIR
    end
    base_dir
  end

  def base_clean_dir
    if options[:base_dir]
      base_dir = options[:base_dir]
    else
      base_dir = DEFAULT_CLEAN_BASE_DIR
    end
    base_dir
  end

  def options
    @options
  end
end

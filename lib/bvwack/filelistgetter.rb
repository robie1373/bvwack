  class FileListGetter
    def initialize(options)
      @options             = options
      @converted_files     = { }
      @not_converted_files = { }
      @to_convert          = []
      get_all_files
    end

    def get_all_files
      if @options[:base_dir]
        base_dir = @options[:base_dir]
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

    def converted_files
      @converted_files
    end

    def not_converted_files
      @not_converted_files
    end

    def get_unconverted_files
      (@not_converted_files.keys - @converted_files.keys).each do |key|
        @to_convert << @not_converted_files[key]
      end
      @to_convert
    end

    def to_clean
      not_converted_files.keys & converted_files.keys
    end

    def lists
      {:converted_files => converted_files, :not_converted_files => not_converted_files, :to_convert => get_unconverted_files, :to_clean => to_clean}
    end
  end

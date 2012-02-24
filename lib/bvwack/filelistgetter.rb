class FileListGetter
  def initialize(options)
    @options             = options
    @converted_files     = { }
    @not_converted_files = { }
    @to_convert          = []
    get_all_files
  end

  def get_all_files
    #puts "FileListGetter.get_all_files @options #{@options}"
    if @options[:base_dir]
      base_dir = @options[:base_dir]
    else
      base_dir = DEFAULT_CONVERT_BASE_DIR
    end
    puts "base dir before chdir #{base_dir}"
    Dir.chdir(base_dir)
    converted_files = Dir.glob(File.join("**", "*ipad.mp4"))
    converted_files.each do |i|
      if i.include?("bvwack-back")
        next
      else
        @converted_files[File.basename(i, ".ipad.mp4")] = i
      end
    end
    #puts "FileListGetter.get_all_files @converted_files #{@converted_files}"
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


    #return @converted_files, @not_converted_files
  end

  def converted_files
    @converted_files
  end

  def not_converted_files
    @not_converted_files
  end

  def get_unconverted_files
    #puts "FileListGetter.get_unconverted_files @converted_files #{@converted_files}"
    #puts "FileListGetter.get_unconverted_files @not_converted_files #{@not_converted_files}"
    (@not_converted_files.keys - @converted_files.keys).each do |key|
      @to_convert << @not_converted_files[key]
    end
    #puts "FileListGetter.get_unconverted_files @to_connvert #{@to_convert}"
    @to_convert
  end
end
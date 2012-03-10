class FileListGetter
  def initialize(args)
    @options  = args[:options]
    @base_dir = args[:base_dir]
    get_all_files
  end

  def get_all_files
    get_original_files(base_dir, ext_grep_pattern)
    get_converted_files(base_dir)
  end

  def get_original_files(base_dir, ext_grep_pattern)
    Dir.chdir(base_dir.base_convert_dir)
    @not_converted_files = {}
    not_converted_files = Dir.glob(File.join("**", "*.{#{ext_grep_pattern}}"))
    not_converted_files.each do |i|
      if i.include?("bvwack-back")
        next
      else
        file_formats.each do |format|
          if File.basename(i).split(".").last == format
            @not_converted_files[File.basename(i, ".#{format}")] = i
          end
        end
      end
    end
  end

  def get_converted_files(base_dir)
    @converted_files = {}
    Dir.chdir(base_dir.base_convert_dir)
    converted_files = Dir.glob(File.join("**", "*ipad.mp4"))
    converted_files.each do |i|
      if i.include?("bvwack-back")
        next
      else
        @converted_files[File.basename(i, ".ipad.mp4")] = i
      end
    end
  end

  def lists
    { :converted_files => converted_files, :not_converted_files => not_converted_files, :to_convert => get_unconverted_files, :to_clean => to_clean }
  end


  private
  def file_formats
    INPUT_FILE_FORMATS
  end

  def ext_grep_pattern
    file_formats.join(',')
  end

  def converted_files
    @converted_files
  end

  def not_converted_files
    @not_converted_files
  end

  def get_unconverted_files
    @to_convert = []
    (@not_converted_files.keys - @converted_files.keys).each do |key|
      @to_convert << @not_converted_files[key]
    end
    @to_convert
  end

  def to_clean
    not_converted_files.keys & converted_files.keys
  end

  def base_dir
    @base_dir
  end

  def options
    @options
  end

end

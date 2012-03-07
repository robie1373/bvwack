class FileListGetter
  def initialize(args)
    @options  = args[:options]
    @base_dir = args[:base_dir]
    get_all_files
    #puts "filelistgetter#init to_clean_list #{to_clean}"
  end

  def get_all_files
    #puts "filelistgetter#get_all_files ext_grep_pattern #{ext_grep_pattern}"
    get_original_files(base_dir, ext_grep_pattern)
    #puts "filelistgetter#get_all_files @not_converted_files = #{@not_converted_files}"
    get_converted_files(base_dir)
    #puts "filelistgetter#get_all_files @converted_files = #{@converted_files}"
  end

  def get_original_files(base_dir, ext_grep_pattern)
    Dir.chdir(base_dir.base_convert_dir)
    @not_converted_files = {}
    #print "filelistgetter#get_original_files dirglobstuff "
    #p (Dir.glob(File.join("**", "*.{#{ext_grep_pattern}}")))
    not_converted_files = Dir.glob(File.join("**", "*.{#{ext_grep_pattern}}"))
    #print "filelistgetter#get_original_files not_converte_files = #{not_converted_files}"
    not_converted_files.each do |i|
      if i.include?("bvwack-back")
        next
      else
        #print "filelistgetter#get_original_files file_formats = #{file_formats}"
        file_formats.each do |format|
          if File.basename(i).split(".").last == format
            @not_converted_files[File.basename(i, ".#{format}")] = i
            #puts "filelistgetter#get_original_files @not_converted_files = #{@not_converted_files}"
            #elsif File.basename(i).split(".").last == "avi"
            #  @not_converted_files[File.basename(i, ".avi")] = i
          end
        end
      end
    end
    #puts "filelistgetter#get_original_files @not_converted_files = #{@not_converted_files}"
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

  #def simple_get_conv_files(base_dir)
  #  Dir.chdir(base_dir.base_convert_dir)
  #  Dir.glob(File.join("**", "*ipad.mp4")).each do |i|
  #    if i.include?("bvwack-back")
  #      next
  #    else
  #      a, b = File.basename(i, ".ipad.mp4"), i
  #    end
  #    [a, b]
  #  end
  #  Hash[arrayish.first, arrayish.last]
  #end

  #def array_conv_files
  #  Dir.glob(File.join("**", "*ipad.mp4")).each do |i|
  #    if i.include?("bvwack-back")
  #      next
  #    else
  #      a, b = File.basename(i, ".ipad.mp4"), i
  #    end
  #    p [a, b]
  #  end
  #end

  def lists
    #puts "filelistgetter#lists converted_files = #{converted_files}\nnot_converted_files #{not_converted_files}\nto_convert #{get_unconverted_files}\nto_clean #{to_clean}"
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

  #TODO this may be broken. It uses instance variables, and does not pass in appropriate things.
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

module BVWack
  class DryCleaner
    def initialize(args)
      @options  = args[:options]
      @list     = args[:lists]
      @file_obj = args[:file_obj]
      @base_dir = args[:base_dir]
      #if @options[:base_dir]
      #  @clean_dir = "#{@options[:base_dir]}/bvwack-back"
      #else
      #  @clean_dir = DEFAULT_CLEAN_BASE_DIR
      #end
    end

    def dry_clean_up
      if to_clean_list.length > 0
        #key      = to_clean_list.pop
        #filename = not_converted_list[key]
        #dirname  = File.dirname(not_converted_list[key])
        puts "DryCleaner#dry_clean_up file_obj #{file_obj}"
        puts %Q{mkdir -p "#{File.join(clean_dir, file_obj.dirname)}" && mv "#{file_obj.filename}" "#{File.join(clean_dir, file_obj.filename)}"\n\n}
      end
    end

    private
    def file_obj
      @file_obj
    end

    def base_dir
      @base_dir
    end

    def base_convert_dir
      base_dir.base_convert_dir
    end

    def base_clean_dir
      base_dir.base_clean_dir
    end

    def list
      @list
    end

    def to_clean_list
      list[:to_clean]
    end

    def not_converted_list
      list[:not_converted_files]
    end
  end
end
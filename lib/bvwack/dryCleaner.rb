module BVWack
  class DryCleaner
    def initialize(args)
      @options = args[:options]
      @list         = args[:lists]
      @file_obj     = args[:file_obj]
      if @options[:base_dir]
        @clean_dir = "#{@options[:base_dir]}/bvwack-back"
      else
        @clean_dir = DEFAULT_CLEAN_BASE_DIR
      end
    end

    def dry_clean_up
      if to_clean_list.length > 0
        key      = to_clean_list.pop
        filename = not_converted_list[key]
        dirname  = File.dirname(not_converted_list[key])
        puts %Q{mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"\n\n}
      end
    end

    def file_obj
      @file_obj
    end

    def clean_dir
      @clean_dir
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
module BVWack
  class DryCleaner
    def initialize(options_list, list)
      @options_list       = options_list
      #@to_clean_list      = to_clean_list
      #@not_converted_list = not_converted_list
      @list = list
      if @options_list[:base_dir]
        @clean_dir = "#{@options_list[:base_dir]}/bvwack-back"
      else
        @clean_dir = DEFAULT_CLEAN_BASE_DIR
      end
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

    def dry_clean_up
      if to_clean_list.length > 0
        key      = to_clean_list.pop
        filename = not_converted_list[key]
        dirname  = File.dirname(not_converted_list[key])
        puts %Q{mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"\n\n}
      end
    end
  end
end
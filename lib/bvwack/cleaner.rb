module BVWack
  class Cleaner
    def initialize(options_list, lists)
      @options_list       = options_list
      #@to_clean_list      = to_clean_list
      #@not_converted_list = not_converted_list
      @lists = lists
      if @options_list[:base_dir]
        @clean_dir = "#{@options_list[:base_dir]}/bvwack-back"
      else
        @clean_dir = DEFAULT_CLEAN_BASE_DIR
      end
    end

    def clean_dir
      @clean_dir
    end

    def lists
      @lists
    end

    def to_clean_list
      lists[:to_clean]
    end

    def not_converted_list
      lists[:not_converted_files]
    end

    def clean_up
      if to_clean_list.length > 0
        key      = to_clean_list.pop
        filename = not_converted_list[key]
        dirname  = File.dirname(not_converted_list[key])
        #`mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"`
        puts %Q{I would have run clean_up\n\tmkdir -p #{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}}
      end
    end
  end
end
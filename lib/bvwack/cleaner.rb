module BVWack
  class Cleaner
    def initialize(args)
      @options = args[:options]
      @lists        = args[:lists]
      @file_obj     = args[:file_obj]
      if @options[:base_dir]
        @clean_dir = "#{@options[:base_dir]}/bvwack-back"
      else
        @clean_dir = DEFAULT_CLEAN_BASE_DIR
      end

    end

    def file_obj
      FileObj.new(:not_converted_list => not_converted_list, :to_clean_list => to_clean_list)
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
        #`mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"`
        puts %Q{I would have run clean_up\n\tmkdir -p #{clean_dir}/#{file_obj.dirname}" && mv "#{file_obj.filename}" "#{clean_dir}/#{file_obj.filename}}
      end
    end

    class FileObj
      def initialize(args)
        @not_converted_list = args[:not_converted_list]
        @to_clean_list      = args[:to_clean_list]
      end

      def not_converted_list
        @not_converted_list
      end

      def to_clean_list
        @to_clean_list
      end

      def dirname
        File.dirname(not_converted_list[key])
      end

      def filename
        not_converted_list[key]
      end

      def key
        to_clean_list.pop
      end

      private :not_converted_list, :to_clean_list
    end
  end
end
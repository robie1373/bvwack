module BVWack
  class Cleaner
    def initialize(args)
      #@options  = args[:options]
      @lists    = args[:lists]
      @file_obj = args[:file_obj]
      @base_dir = args[:base_dir]

      #if @options[:base_dir]
      #  @clean_dir = "#{@options[:base_dir]}/bvwack-back"
      #else
      #  @clean_dir = DEFAULT_CLEAN_BASE_DIR
      #end
    end

    def clean_up
      if to_clean_list.length > 0
        #`mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"`
        puts "Cleaner#clean_up file_obj.dirname #{file_obj.dirname}"
        puts %Q{I would have run clean_up\n\tmkdir -p #{File.join(base_clean_dir, file_obj.dirname)}" && mv "#{file_obj.filename} #{File.join(base_clean_dir, file_obj.filename)}"}
      end
    end

    private
    def file_obj
      FileObj.new(:not_converted_list => not_converted_list, :to_clean_list => to_clean_list)
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

    def lists
      @lists
    end

    def to_clean_list
      lists[:to_clean]
    end

    def not_converted_list
      lists[:not_converted_files]
    end
  end
end
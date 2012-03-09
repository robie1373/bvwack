module BVWack
  class DryCleaner
    def initialize(args)
      #@lists    = args[:lists]
      @file_obj = args[:file_obj]
      @base_dir = args[:base_dir]
      @iteration = args[:iteration]
      puts "dryCleaner#init @iteration #{p @iteration}"
    end

    def dry_clean_up
      #if to_clean_list.length > 0
        p "#{mv_string}\n\n"
      #end
    end

    private
    def mv_string
      %Q{mkdir -p "#{File.join(base_clean_dir, file_obj.dirname(iteration))}" && mv "#{file_obj.filename(iteration)} #{File.join(base_clean_dir, file_obj.filename(iteration))}"}
    end

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

    def iteration
      #puts "drycleaner#iteration #{p @iteration}"
      @iteration
    end

    #def list
    #  @lists
    #end

    #def to_clean_list
    #  lists.list[:to_clean]
    #end

    #def not_converted_list
    #  lists.list[:not_converted_files]
    #end
  end
end
module BVWack
  class Cleaner
    def initialize(args)
      @file_obj = args[:file_obj]
      @base_dir = args[:base_dir]
      @iteration = args[:iteration]
    end

    def clean_up
      if file_obj.path_to_file(iteration).class == String
        `#{mv_string}`
        #p "I would have run clean_up\n\t#{mv_string}"
      end
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
      @iteration
    end
  end
end
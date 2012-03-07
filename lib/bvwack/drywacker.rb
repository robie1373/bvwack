module BVWack
  class DryWacker
    def initialize(args)
      #@lists     = args[:lists]
      @iteration = args[:iteration]
      @file_obj  = args[:file_obj]
    end

    def dry_wack
      if file_obj.path_to_file(iteration).class == String
        p "#{ffmpeg_string}\n\n"
      end
    end

    private
    def ffmpeg_string
      %Q{ffmpeg -i "#{file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"}
    end

    def file_obj
      @file_obj
    end

    def lists
      @lists
    end

    def iteration
      @iteration
    end

    #def file_obj.path_to_file(iteration)
    #  lists[:to_convert][iteration]
    #end
  end
end
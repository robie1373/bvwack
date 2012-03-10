class Wacker
  def initialize(args)
    @iteration = args[:iteration]
    @file_obj  = args[:file_obj]
  end

  def wack
    if file_obj.path_to_file(iteration).class == String
      `#{ffmpeg_string}`
      #p "I would have run\n\t#{ffmpeg_string}"
    end
  end

  private
  def ffmpeg_string
    %Q{ffmpeg -i "#{file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"}
  end

  def file_obj
    @file_obj
  end

  def iteration
    @iteration
  end
end
class Wacker
  def initialize(args)
    @list      = args[:lists]
    @iteration = args[:iteration]
    @file_obj  = args[:file_obj]
  end

  def wack
    if file_obj.path_to_file(iteration).class == String
      $PROGRAM_NAME = "bvwack #{File.basename(file_obj.path_to_file(iteration))}"

      #`ffmpeg -i "#{file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"`
      puts %Q{I would have run\n\tffmpeg -i "#{file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"}
    end
  end

  private
  def file_obj
    @file_obj
  end

  def iteration
    @iteration
  end

  def list
    @list
  end
end
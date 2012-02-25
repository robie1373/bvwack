class Wacker
  def initialize(list, iteration)
    @list = list
    @iteration = iteration
  end

  def iteration
    @iteration
  end

  def list
    @list
  end

  def path_to_file
    list[:to_convert][iteration]
  end

  def wack
    if path_to_file.class == String
      $PROGRAM_NAME = "bvwack #{File.basename(path_to_file)}"

      #`ffmpeg -i "#{path_to_file}" #{FFMPEG_OPTS} "#{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}"`
      puts %Q{I would have run\n\tffmpeg -i "#{path_to_file}" #{FFMPEG_OPTS} "#{path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}"}
    end
  end
end
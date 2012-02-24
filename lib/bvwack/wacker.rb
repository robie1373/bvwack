class Wacker
  def initialize(path_to_file)
    @path_to_file = path_to_file
  end

  def wack
    if @path_to_file.class == String
      `ffmpeg -i "#{@path_to_file}" #{FFMPEG_OPTS} "#{@path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}"`
    end
  end
end

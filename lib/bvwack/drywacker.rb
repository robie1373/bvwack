class DryWacker
  def initialize(path_to_file)
    @path_to_file = path_to_file
  end

  def dry_wack
    #print "@path_to_file "
    #p @path_to_file
    if @path_to_file.class == String
      puts "ffmpeg -i #{@path_to_file} #{FFMPEG_OPTS} #{@path_to_file.gsub(/mkv$|avi$/, "ipad.mp4")}\n\n"
    end
  end
end

DEFAULT_CONVERT_BASE_DIR = "#{ENV['PWD']}"
DEFAULT_CLEAN_BASE_DIR   = "#{File.join(ENV['PWD'], "bvwack-back")}"
DEFAULT_ITERATION_LIMIT  = 2
DEFAULT_THREADS          = 3
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads #{DEFAULT_THREADS} -strict experimental"
INPUT_FILE_FORMATS       = %w{ mkv avi }
#MV_STRING                = %Q{mkdir -p "#{File.join(base_clean_dir, file_obj.dirname)}" && mv "#{file_obj.filename} #{File.join(base_clean_dir, file_obj.filename)}"}

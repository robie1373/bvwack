DEFAULT_CONVERT_BASE_DIR = "#{ENV['PWD']}"
DEFAULT_CLEAN_BASE_DIR   = "#{ENV['PWD']}/bvwack-back"
FFMPEG_OPTS              = "-acodec aac -ac 2 -ab 160k -s 1024x768 -vcodec libx264 -vpre slow -vpre iPod640 -vb 1200k -f mp4 -threads 2 -strict experimental"

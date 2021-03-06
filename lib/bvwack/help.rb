require_relative 'bvwack_version'

include BVWack

class Help

  def be_helpful
    puts "
  Usage: bvwack <options>

  version #{BVWack::VERSION}

  Default action is equivalent to bvwack -n 2

  Options:
      -b BASE_DIR, --base-dir BASE_DIR  Set BASE_DIR instead of /Volumes/thundar/media/video
      -d, --dry-run                     Do a dry run. Prints proposed commands to STDOUT.
      -c, --clean-up                    Instead of converting, move all converted files to /Volumes/thundar/media/converted/[old-path]
      -n #, --num-files #               Number of videos to batch.
      -l, --list_converted              Lists files that have been converted but not cleaned. Useful for vierifying successful conversion.

  Notes: By default this will not work for you. You must change DEFAULT_CONVERT_BASE_DIR
         and DEFAULT_CLEAN_BASE_DIR to something that exists on your system. Do not let
         the clean dir be a subdirectory of base dir or you'll be sad. I have set the
         FFMPEG options to use only 2 threads. This allows me to use my laptop while
         converting things. If you just want to hog through video try setting -threads 0
         in FFMPEG_OPTS. Currently this only works on UNIX-like systems.

  Requirements: ffmpeg and a libx264-slow.ffpreset (possibly in your ~/.ffmpeg/ directory or in your Cellar if you use brew.) Google is your friend.

  Examples:
      bvwack -dw                             Shows proposed commands for 2 videos
      bvwack -w -b somedir/anotherdir -n 5   Converts 5 videos under somedir/anotherdir
      bvwack -c -n 10                        Moves 10 already converted mkv or avi files to /Volumes/thundar/medai/converted/[od-path]"

  end
end

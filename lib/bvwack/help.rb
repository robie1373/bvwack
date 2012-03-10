require_relative 'bvwack_version'

include BVWack

class Help

  def be_helpful
  "
  Usage: bvwack [-c|-w|-l] <options>

  version #{BVWack::VERSION}

  Default action is equivalent to bvwack -n 2. You must specify one of c, w, or l.

  Options:
      -b BASE_DIR, --base-dir BASE_DIR  Set BASE_DIR instead of ./
      -d, --dry-run                     Do a dry run of either clean or wack. Prints proposed commands to STDOUT.
      -c, --clean-up                    Instead of converting, move all converted files to BASE_DIR/[old-path]
      -n #, --num-files #               Number of videos to batch.
      -l, --list_converted              Lists files that have been converted but not cleaned. Useful for verifying successful conversion.
      -w, --wack                        Converts (wacks) videos.

  Notes: I have set the FFMPEG options to use only 2 threads. This allows me to use my laptop while
         converting things. If you just want to hog through video try setting -threads 0
         in FFMPEG_OPTS in constants.rb. This is not tested on Windows.

  Requirements: ffmpeg and a libx264-slow.ffpreset (possibly in your ~/.ffmpeg/ directory or in your Cellar if you use brew.) Google is your friend.

  Examples:
      bvwack -dw                             Shows proposed commands for 2 videos
      bvwack -w -b somedir/anotherdir -n 5   Converts 5 videos under somedir/anotherdir
      bvwack -c -n 10                        Moves 10 already converted mkv or avi files to ./[old-path]"

  end
end

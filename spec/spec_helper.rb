require_relative '../lib/bvwack/actionator'
require_relative '../lib/bvwack/bvwack_version'
require_relative '../lib/bvwack/cleaner'
require_relative '../lib/bvwack/constants'
require_relative '../lib/bvwack/dryCleaner'
require_relative '../lib/bvwack/drywacker'
require_relative '../lib/bvwack/echobasedirs'
require_relative '../lib/bvwack/filelistgetter'
require_relative '../lib/bvwack/fileobj'
require_relative '../lib/bvwack/help'
require_relative '../lib/bvwack/limiter'
require_relative '../lib/bvwack/lister'
require_relative '../lib/bvwack/options'
require_relative '../lib/bvwack/runner'
require_relative '../lib/bvwack/wacker'

def spec_lists
  { :converted_files => spec_converted_files, :not_converted_files => spec_not_converted_files, :to_convert => spec_to_convert, :to_clean => spec_to_clean }
end

def spec_not_converted_files
  { "dir1/file1" => "dir1/file1.avi", "dir1/dir2/file1" => "dir1/dir2/file1.mkv", "dir1/file2" => "dir1/file2.mkv" }
end
def spec_not_converted_dirs
  %w{dir1 dir1/dir2 dir1}
end

def spec_converted_files
  { "dir1/file1" => "dir1/file1.ipad.mp4", "dir1/dir2/file1" => "dir1/dir2/file1.ipad.mp4", "dir1/file2" => "dir1/file2.ipad.mp4" }
end

def spec_to_convert
  %w{ dir1/file1.avi dir1/dir2/file1.mkv }
end

def spec_to_clean
  %w{ dir1/file2 }
end

class SpecBaseDirs
  def base_convert_dir
    "foo/bar"
  end

  def base_clean_dir
    "foo/bar/bvwack-back"
  end
end

class SpecFileObj
  def initialize(lists)
    @lists = lists
  end

  def dirname
    "dir1/file1"
  end

  def filename
    "dir1/file1.avi"
  end

  def path_to_file(iteration)
    spec_to_convert[iteration]
    #"dir1/file1"
  end

  def key
    "dir1/file2"
  end
end

def commands
  [:list_converted, :dry_clean_up, :clean_up, :dry_wack, :wack]
end


require_relative 'fileobj'
require_relative 'filelistgetter'
require_relative 'limiter'
require_relative 'echobasedirs'
require_relative 'drywacker'
require_relative 'dryCleaner'
require_relative 'cleaner'
require_relative 'wacker'
require_relative 'lister'
require 'ap'

class Runner
  def initialize(args)
    @command = args[:command]
    @options = args[:options]
    lists
    ap lists
  end

  def run
    base_dir.echo_base_dirs
    if command == :list_converted
      Lister.new(:lists => lists, :base_dir => base_dir, :file_obj => file_obj).list_converted
    else
      (0..iteration_limit).each do |i|
        case
          when command == :dry_clean_up
            DryCleaner.new(:file_obj => file_obj, :base_dir => base_dir, :iteration => i).dry_clean_up

          when command == :clean_up
            Cleaner.new(:file_obj => file_obj, :base_dir => base_dir, :iteration => i).clean_up

          when command == :dry_wack
            DryWacker.new(:iteration => i, :file_obj => file_obj).dry_wack

          when command == :wack
            Wacker.new(:iteration => i, :file_obj => file_obj).wack
          else
        end
      end
    end
  end

  private
  def base_dir
    EchoBaseDirs.new(:options => options)
  end

  def file_obj
    FileObj.new(:lists => lists)
  end

  def iteration_limit
    Limiter.new(:options => options).set_limit
  end

  def lists
    FileListGetter.new(:options => options, :base_dir => base_dir).lists
  end

  def command
    @command
  end

  def options
    @options
  end
end

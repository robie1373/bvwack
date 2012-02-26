require_relative 'fileobj'
require_relative 'filelistgetter'
require_relative 'limiter'
require_relative 'echobasedirs'


class Runner
  def initialize(args)
    @command = args[:command]
    @options = args[:options]
    puts "Runner#init lists #{lists}"
    puts "runner#init lists[:not_converted] #{lists[:not_converted_files]}"
  end

  def run
    base_dir.echo_base_dirs
    (0..iteration_limit).each do |i|
      case
        when command == :list_converted
          Lister.new(:lists => lists, :base_dir => base_dir, :file_obj => file_obj).list_converted
        when command == :dry_clean_up
          DryCleaner.new(:options => options, :lists => lists, :file_obj => file_obj, :base_dir => base_dir).dry_clean_up

        when command == :clean_up
          Cleaner.new(:lists => lists, :file_obj => file_obj, :base_dir => base_dir).clean_up

        when command == :dry_wack
          DryWacker.new(:lists => lists, :iteration => i, :file_obj => file_obj).dry_wack
        when command == :wack
          Wacker.new(:lists => lists, :iteration => i, :file_obj => file_obj).wack
        else
      end
    end
  end

  def base_dir
    EchoBaseDirs.new(:options => options)
  end

  def file_obj
    FileObj.new(:lists => @lists)
  end

  def iteration_limit
    Limiter.new(:options => options).set_limit
  end

  def lists
    FileListGetter.new(:options => options, :base_dir => base_dir)
  end

  def command
    @command
  end

  def options
    @options
  end
end

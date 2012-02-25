require_relative 'fileobj'
class Runner
  def initialize(args)
    @command         = args[:command]
    @options         = args[:options]
    @iteration_limit = args[:iteration_limit]
    @lists           = args[:lists]
    @file_obj        = FileObj.new(:not_converted_list => @lists[:not_converted_list], :to_clean_list => @lists[:to_clean_list])
  end

  def run
    base_dirs = EchoBaseDirs.new(options)
    base_dirs.echo_base_dirs
    (0..iteration_limit).each do |i|
      case
        when command == :list_converted
          Lister.new(lists, base_dirs.base_convert_dir).list_converted
        when command == :dry_clean_up
          DryCleaner.new(options, lists).dry_clean_up

        when command == :clean_up
          Cleaner.new(:options => options, :lists => lists, :file_obj => file_obj).clean_up

        when command == :dry_wack
          DryWacker.new(lists, i).dry_wack
        when command == :wack
          Wacker.new(lists, i).wack
        else
      end
    end
  end

  def file_obj
    @file_obj
  end

  def command
    @command
  end

  def options
    @options
  end

  def iteration_limit
    @iteration_limit
  end

  def lists
    @lists
  end
end

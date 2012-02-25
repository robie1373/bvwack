class Runner
  #def initialize(command, options, iteration_limit, to_clean_list, not_converted_list, to_convert_list)
  #def initialize(command, options, iteration_limit, lists)
  def initialize(args)
    @command            = args[:command]
    @options            = args[:options]
    @iteration_limit    = args[:iteration_limit]
    #@to_clean_list      = to_clean_list
    #@not_converted_list = not_converted_list
    #@to_convert_list    = to_convert_list
    @lists = args[:lists]
    #puts "runner#init @lists object #{@lists}"

  end

  def run
    base_dirs = EchoBaseDirs.new(@options)
    base_dirs.echo_base_dirs
    (0..@iteration_limit).each do |i|
      case
        when @command == :list_converted
          Lister.new(@lists, base_dirs.base_convert_dir).list_converted
          #Lister.new(@to_clean_list, @converted_file_list, @not_converted_list, base_dirs.base_convert_dir).list_converted
        when @command == :dry_clean_up
          DryCleaner.new(@options, @lists).dry_clean_up
        when @command == :clean_up
          Cleaner.new(@options, @lists).clean_up

        when @command == :dry_wack
          #file = @to_convert_list[i]
          DryWacker.new(@lists, i).dry_wack

        when @command == :wack
          #file = @to_convert_list[i]
          Wacker.new(@lists, i).wack
        else
      end
    end
  end
end

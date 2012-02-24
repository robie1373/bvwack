class Runner
  def initialize(command, options, iteration_limit, to_clean_list, not_converted_list, to_convert_list)
    @command            = command
    @options            = options
    @iteration_limit    = iteration_limit
    @to_clean_list      = to_clean_list
    @not_converted_list = not_converted_list
    @to_convert_list    = to_convert_list
  end

  def run

    EchoBaseDirs.new(@options).echo_base_dirs
    (0..@iteration_limit).each do |i|
      case
        when @command == :dry_clean_up
          DryCleaner.new(@options, @to_clean_list, @not_converted_list).dry_clean_up
        when @command == :clean_up
          Cleaner.new(@options, @to_clean_list, @not_converted_list).clean_up
        when @command == :dry_run
          file = @to_convert_list[i]
          dry_run(file)
        when @command == :convert
          file = @to_convert_list[i]
          convert(file)
        else
      end
    end
  end
end

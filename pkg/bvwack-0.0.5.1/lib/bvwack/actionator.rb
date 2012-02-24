class Actionator
  def initialize(options, to_clean_list, converted_file_list, not_converted_list, to_convert_list, iteration_limit)
    @options              = options
    @to_clean_list        = to_clean_list
    @converted_files_list = converted_file_list
    @not_converted_list   = not_converted_list
    @to_convert_list      = to_convert_list
    @iteration_limit      = iteration_limit
  end

  def actionate
    case
      when @options[:wack] == TRUE && @options[:clean_up] == TRUE
        puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
      when @options[:list_converted] == TRUE
        Lister.new(@to_clean_list, @converted_file_list, @not_converted_list).list_converted
      when @options[:dry_run] == TRUE && @options[:clean_up] == TRUE
        Runner.new(:dry_clean_up, @options, @iteration_limit, @to_clean_list, @not_converted_list, @to_convert_list).run
      when @options[:clean_up] == TRUE
        Runner.new(:clean_up, @options, @iteration_limit, @to_clean_list, @not_converted_list, @to_convert_list).run
      when @options[:dry_run] == TRUE && @options[:wack] == TRUE
        Runner.new(:dry_wack, @options, @iteration_limit, @to_clean_list, @not_converted_list, @to_convert_list).run
      when @options[:wack] == TRUE
        Runner.new(:wack, @options, @iteration_limit, @to_clean_list, @not_converted_list, @to_convert_list).run
      else
        man = Help.new
        man.be_helpful
    end
  end
end
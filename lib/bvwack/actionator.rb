module BVWack
  class Actionator
    def initialize(options, lists, iteration_limit)
      @options         = options
      @iteration_limit = iteration_limit
      @lists           = lists
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

    def actionate
      case
        when options[:wack] == TRUE && options[:clean_up] == TRUE
          puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
        when options[:list_converted] == TRUE
          Runner.new(:command => :list_converted, :options => options, :iteration_limit => iteration_limit, :lists => lists).run
        when options[:dry_run] == TRUE && options[:clean_up] == TRUE
          Runner.new(:command => :dry_clean_up, :options => options, :iteration_limit => iteration_limit, :lists => lists).run
        when options[:clean_up] == TRUE
          Runner.new(:command => :clean_up, :options => options, :iteration_limit => iteration_limit, :lists => lists).run
        when options[:dry_run] == TRUE && options[:wack] == TRUE
          Runner.new(:command => :dry_wack, :options => options, :iteration_limit => iteration_limit, :lists => lists).run
        when options[:wack] == TRUE
          Runner.new(:command => :wack, :options => options, :iteration_limit => iteration_limit, :lists => lists).run
        else
          man = Help.new
          man.be_helpful
      end
    end
  end
end

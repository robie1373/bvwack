require_relative 'help'
require_relative 'runner'
require_relative 'options'

class Actionator
  def initialize
    @options = GetOptions.new.put_options
    print "Command line options: #{@options}\n"
  end

  def actionate
    case
      when options[:wack] == TRUE && options[:clean_up] == TRUE
        puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
      when options[:list_converted] == TRUE
        Runner.new(:command => :list_converted, :options => options).run
      when options[:dry_run] == TRUE && options[:clean_up] == TRUE
        Runner.new(:command => :dry_clean_up, :options => options).run
      when options[:clean_up] == TRUE
        Runner.new(:command => :clean_up, :options => options).run
      when options[:dry_run] == TRUE && options[:wack] == TRUE
        Runner.new(:command => :dry_wack, :options => options).run
      when options[:wack] == TRUE
        Runner.new(:command => :wack, :options => options).run
      else
        Help.new.be_helpful
    end
  end

  private
  def options
    @options
  end
end


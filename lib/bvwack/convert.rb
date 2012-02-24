require_relative 'help'
require_relative 'options'
require_relative 'lister'
require_relative 'drycleaner'
require_relative 'cleaner'
require_relative 'echobasedirs'
require_relative 'runner'
require_relative 'wacker'
require_relative 'drywacker'
require_relative 'limiter'
require_relative 'filelistgetter'
require_relative 'constants'


#class SetUp
#  def initialize(options)
#    @options          = options
#    @file_list_getter = FileListGetter.new(@options)
#  end
#
#  def prepare
#    @converted_files, @not_converted_files = @file_list_getter.get_all_files
#    @to_convert                            = @file_list_getter.get_unconverted_files
#    @to_clean                              = @not_converted_files.keys & @converted_files.keys
#    return @converted_files, @not_converted_files, @to_convert, @to_clean
#  end
#
#  def converted_files
#    @file_list_getter.get_all_files.converted_files
#  end
#
#
#end


options = GetOptions.new.put_options
p options
iteration_limit      = Limiter.new(options).set_limit
file_list_getter     = FileListGetter.new(options)
file_list_getter.get_all_files
@converted_files     = file_list_getter.converted_files
@not_converted_files = file_list_getter.not_converted_files
@to_convert          = file_list_getter.get_unconverted_files
puts "@to_convert #{@to_convert}"
@to_clean            = @not_converted_files.keys & @converted_files.keys
puts "@to_clean #{@to_clean}"

case
  when options[:wack] == TRUE && options[:clean_up] == TRUE
    puts("Error! -w (--wack) and -c (--clean-up) cannot be used simultaneously.")
  when options[:list_converted] == TRUE
    Lister.new(@to_clean, @converted_files, @not_converted_files).list_converted
  when options[:dry_run] == TRUE && options[:clean_up] == TRUE
    Runner.new(:dry_clean_up, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  when options[:clean_up] == TRUE
    Runner.new(:clean_up, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  when options[:dry_run] == TRUE && options[:wack] == TRUE
    Runner.new(:dry_wack, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  when options[:wack] == TRUE
    Runner.new(:wack, options, iteration_limit, @to_clean, @not_converted_files, @to_convert).run
  else
    man = Help.new
    man.be_helpful
end

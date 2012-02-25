require_relative 'bvwack/help'
require_relative 'bvwack/options'
require_relative 'bvwack/lister'
require_relative 'bvwack/drycleaner'
require_relative 'bvwack/cleaner'
require_relative 'bvwack/echobasedirs'
require_relative 'bvwack/runner'
require_relative 'bvwack/wacker'
require_relative 'bvwack/drywacker'
require_relative 'bvwack/limiter'
require_relative 'bvwack/filelistgetter'
require_relative 'bvwack/constants'
require_relative 'bvwack/actionator'

options = GetOptions.new.put_options
print "Command line options: #{options}\n"
iteration_limit     = Limiter.new(options).set_limit
file_list_getter    = FileListGetter.new(options)
lists = file_list_getter.lists
Actionator.new(options, lists, iteration_limit).actionate

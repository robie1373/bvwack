#require_relative 'bvwack/options'
require_relative 'bvwack/actionator'

#require_relative 'bvwack/lister'
#require_relative 'bvwack/drycleaner'
#require_relative 'bvwack/cleaner'
#require_relative 'bvwack/echobasedirs'
#require_relative 'bvwack/runner'
#require_relative 'bvwack/wacker'
#require_relative 'bvwack/drywacker'
#require_relative 'bvwack/limiter'
#require_relative 'bvwack/filelistgetter'
#require_relative 'bvwack/constants'
#require_relative 'bvwack/fileobj'
#require_relative 'bvwack/help'


#file_obj = FileObj.new(lists)
#puts "bvwack lists #{lists[:to_clean]}"
Actionator.new.actionate

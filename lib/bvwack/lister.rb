class Lister
  def initialize(args)
    @base_dir = args[:base_dir]
    @lists    = args[:lists]
    @file_obj = args[:file_obj]
  end

  def list_converted
    #puts "lister#list_converted to_clean_list #{to_clean_list}  "
    begin
      while to_clean_list
        key                   = to_clean_list.pop
        converted_filename    = converted_file_list[key]
        not_converted_filename = not_converted_list[key]
        dirname               = File.dirname(not_converted_list[key])
        puts "\nConverted file:\n"
        #p file_obj
        puts %Q{In Directory "#{dirname}"}
        p `ls -lh "#{converted_filename}"`
        p `ls -lh "#{not_converted_filename}"`
        puts %Q{To test run:  open "#{File.join(base_dir, converted_filename)}"}
        puts "\n"
      end
    rescue
      puts("\nNothing to list")
    end
  end

  def file_obj
    @file_obj
  end

  def base_dir
    @base_dir
  end

  def to_clean_list
    @lists[:to_clean]
  end

  def converted_file_list
    @lists[:converted_files]
    #{ "123" => "456"}
  end

  def not_converted_list
    @lists[:not_converted_files]
    #{ "abc" => "cde"}
  end

end
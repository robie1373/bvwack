class Lister
  #def initialize(to_clean_list, converted_file_list, not_converted_list, base_dir)
  def initialize(lists, base_dir)
    #@to_clean_list       = to_clean_list
    #@converted_file_list = converted_file_list
    #@not_converted_list  = not_converted_list
    @base_dir = base_dir
    @lists = lists
    #puts "initialize converted_file_list #{p @converted_file_list}"
  end

  def base_dir
    @base_dir
  end

  def to_clean_list
    to_clean_list = @lists[:to_clean]
    to_clean_list
  end

  def converted_file_list
    @lists[:converted_files]
    #{ "123" => "456"}
  end

  def not_converted_list
    @lists[:not_converted_files]
    #{ "abc" => "cde"}
  end

  def list_converted
    #puts "lister#list_converted ro_clean_list #{to_clean_list}"

    begin
      while to_clean_list
        key                = to_clean_list.pop
        #puts "converted_file_list #{p converted_file_list}"
        converted_filename = converted_file_list[key]
        #puts "not converted list #{not_converted_list}"
        old_filename       = not_converted_list[key]
        #p old_filename
        dirname            = File.dirname(not_converted_list[key])
        puts "\nConverted file:\n"
        puts %Q{In Directory "#{dirname}"}
        p `ls -lh "#{converted_filename}"`
        p `ls -lh "#{old_filename}"`
        puts %Q{To test run:  open "#{File.join(base_dir, converted_filename)}"}
        puts "\n"
      end
    rescue
      puts("\nNothing to list")
    end
  end
end
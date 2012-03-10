class Lister
  def initialize(args)
    @base_dir = args[:base_dir]
    @lists    = args[:lists]
    @file_obj = args[:file_obj]
  end

  def list_converted
    #puts "lister#list_converted to_clean_list #{to_clean_list}  "
    #begin
      (0 .. (converted_file_list.keys.length - 1)).each do |i|
        #key                    = to_clean_list.pop
        #converted_filename     = converted_file_list[key]
        #not_converted_filename = not_converted_list[key]
        #dirname                = File.dirname(not_converted_list[key])
        puts "\nConverted file:\n"
        #p file_obj
        puts %Q{In Directory "#{dirname(i)}"}
        p `ls -lh "#{converted_file_list[converted_file_list.keys[i]]}"`
        p `ls -lh "#{not_converted_list[not_converted_list.keys[i]]}"`
        #puts "lister#list_converted converted_file_list = #{converted_file_list[converted_file_list.keys[i]]}"
        #puts "lister#list_converted not_converted_list = #{not_converted_list}"
        puts %Q{To test run:  open "#{File.join(base_convert_dir, converted_file_list[converted_file_list.keys[i]])}"}
        puts "\n"
      #end
    #rescue
    #  puts("\nNothing to list")
      #raise "No File", caller
    end
  end

  private
  def lists
    @lists
  end

  def file_obj
    @file_obj
  end

  def dirname(iteration)
    file_obj.dirname(iteration)
  end

  def base_dir
    @base_dir
  end

  def base_convert_dir
    base_dir.base_convert_dir
  end

  def to_clean_list
    lists[:to_clean]
    #p lists[:to_clean]
  end

  def converted_file_list
    lists[:converted_files]
    #p lists[:converted_files]
    #{ "123" => "456"}
  end

  def not_converted_list
    lists[:not_converted_files]
    #{ "abc" => "cde"}
  end
end
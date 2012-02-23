class Lister
  def initialize(to_clean_list, converted_files_list, not_converted_files_list)
    @to_clean_list            = to_clean_list
    @converted_files_list     = converted_files_list
    @not_converted_files_list = not_converted_files_list
  end

  def list_converted
    begin
      while @to_clean_list
        key                = @to_clean_list.pop
        converted_filename = @converted_files_list[key]
        old_filename       = @not_converted_files_list[key]
        dirname            = File.dirname(@not_converted_files_list[key])
        puts "\nConverted file:\n"
        puts %Q{In Directory "#{dirname}"}
        p `ls -lh "#{converted_filename}"`
        p `ls -lh "#{old_filename}"`
        puts %Q{To test run:  open "#{converted_filename}"}
        puts "\n"
      end
    rescue
      puts("\nNothing to list")
    end
  end
end
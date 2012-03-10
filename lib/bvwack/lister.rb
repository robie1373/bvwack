class Lister
  def initialize(args)
    @base_dir = args[:base_dir]
    @lists    = args[:lists]
    @file_obj = args[:file_obj]
  end

  def list_converted
    begin
      (0 .. (to_clean_list.length - 1)).each do |i|
        key = to_clean_list[i]
        puts "lister#list_converted key= #{key}"
        puts "\nConverted file:\n"
        puts %Q{In Directory "#{dirname(i)}"}
        p `ls -lh "#{converted_file_list[key]}"`
        p `ls -lh "#{not_converted_list[key]}"`
        puts %Q{To test run:  open "#{File.join(base_convert_dir, converted_file_list[key])}"}
        puts "\n"
      end
    rescue
      puts("\nNothing to list")
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
  end

  def converted_file_list
    lists[:converted_files]
  end

  def not_converted_list
    lists[:not_converted_files]
  end
end
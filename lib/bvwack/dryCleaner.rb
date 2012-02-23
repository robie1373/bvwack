class DryCleaner
  def initialize(options, to_clean_list, not_converted_list)
    @options = options
    @to_clean_list = to_clean_list
    @not_converted_files_list = not_converted_list
  end

  def dry_clean_up
    if @options[:base_dir]
      clean_dir = "#{@options[:base_dir]}/bvwack-back"
    else
      clean_dir = DEFAULT_CLEAN_BASE_DIR
    end
    if @to_clean_list.length > 0
      key      = @to_clean_list.pop
      filename = @not_converted_list[key]
      dirname  = File.dirname(@not_converted_list[key])
      puts %Q{mkdir -p "#{clean_dir}/#{dirname}" && mv "#{filename}" "#{clean_dir}/#{filename}"\n\n}
      #else
      #  puts "No more files to clean. Hooray!"
    end
  end
end
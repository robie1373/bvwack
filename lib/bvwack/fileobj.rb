class FileObj
  def initialize(args)
    @lists = args[:lists]
    @iteration = args[:iteration]
    #@to_clean_list      = args[:to_clean_list]
    #@to_convert         = args[:to_convert]
    #puts "File0bj#init @original_file_list #{@original_file_list}"
    #puts "fileObj#init to_convert  #{@lists.lists[:to_convert]}"
  end

  def dirname
    puts "fileobj#dirname original_file_list[key] = #{original_file_list[iteration][key]}"
    File.dirname(original_file_list[iteration][key])
  end

  def filename
    original_file_list[key]
  end

  def path_to_file(iteration)
    to_convert[iteration]
  end

  def key
    to_clean_list.pop
  end

  private
  def converted_filename
    converted_file_list[key]
  end

  def original_filename
    original_file_list[key]
  end

  def lists
    @lists
  end

  #TODO rename not_converted_list to original_file_list
  def original_file_list
    lists.lists[:not_converted_files]
  end

  def to_clean_list
    lists.lists[:to_clean]
  end

  def to_convert
    #puts "fileobj#to_convert lists #{p lists.lists[:to_convert]}"
    lists.lists[:to_convert]
  end

  def iteration
    @iteration
  end
end

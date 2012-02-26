class FileObj
  def initialize(args)
    @lists = args[:lists]
    #@to_clean_list      = args[:to_clean_list]
    #@to_convert         = args[:to_convert]
    #puts "File0bj#init @not_converted_list #{@not_converted_list}"
    #puts "fileObj#init @to_clean_list #{@to_clean_list}"
  end

  def dirname
    File.dirname(not_converted_list[key])
  end

  def filename
    not_converted_list[key]
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

  #TODO rename not_converted_filename to original_filename
  def not_converted_filename
    not_converted_list[key]
  end

  def lists
    @lists
  end

  #TODO rename not_converted_list to original_file_list
  def not_converted_list
    lists[:not_converted_files]
  end

  def to_clean_list
    lists[:to_clean]
  end

  def to_convert
    lists[:to_convert]
  end
end

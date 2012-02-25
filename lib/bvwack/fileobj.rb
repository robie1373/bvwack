class FileObj
  def initialize(args)
    @not_converted_list = args[:not_converted_list]
    @to_clean_list      = args[:to_clean_list]
    @to_convert         = args[:to_convert]
  end

  #TODO rename not_converted_list to original_file_list
  def not_converted_list
    @not_converted_list
  end

  def to_clean_list
    @to_clean_list
  end

  def to_convert
    @to_convert
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

  def converted_filename
    converted_file_list[key]
  end

  #TODO rename not_converted_filename to original_filename
  def not_converted_filename
    not_converted_list[key]
  end

  private :not_converted_list, :to_clean_list
end

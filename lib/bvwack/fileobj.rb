class FileObj
  def initialize(args)
    @not_converted_list = args[:not_converted_list]
    @to_clean_list      = args[:to_clean_list]
    @to_convert         = args[:to_convert]
  end

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

  private :not_converted_list, :to_clean_list
end

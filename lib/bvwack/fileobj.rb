class FileObj
  def initialize(args)
    @not_converted_list = args[:not_converted_list]
    @to_clean_list      = args[:to_clean_list]
  end

  def not_converted_list
    @not_converted_list
  end

  def to_clean_list
    @to_clean_list
  end

  def dirname
    File.dirname(not_converted_list[key])
  end

  def filename
    not_converted_list[key]
  end

  def key
    to_clean_list.pop
  end

  private :not_converted_list, :to_clean_list
end

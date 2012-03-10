require 'ap'

class FileObj
  def initialize(args)
    @lists = args[:lists]
  end

  def dirname(iteration)
    File.dirname(original_file_list[key(iteration)])
  end

  def filename(iteration)
    original_file_list[key(iteration)]
  end

  def path_to_file(iteration)
    to_convert[iteration]
  end

  def key(iteration)
    original_file_list.keys[iteration]
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
    lists[:not_converted_files]
  end

  def to_clean_list
    lists[:to_clean]
  end

  def to_convert
    lists[:to_convert]
  end
end

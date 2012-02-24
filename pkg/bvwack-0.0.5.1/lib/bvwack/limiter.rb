require_relative "constants"

class Limiter
  def initialize(options)
    @options = options
  end

  def set_limit
    if @options[:num_files]
      limit = (@options[:num_files] - 1).to_i
    else
      limit = DEFAULT_ITERATION_LIMIT
    end
    limit
  end
end

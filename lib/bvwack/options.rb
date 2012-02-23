require 'optparse'

class GetOptions
  def initialize
    @options = {}
    option_parser = OptionParser.new do |opts|
      opts.on("-d", "--dry-run") do
        @options[:dry_run] = true
      end

      opts.on("-b BASE_DIR", "--base-dir BASE_DIR") do |base_dir|
        @options[:base_dir] = base_dir
      end

      opts.on("-c", "--clean-up") do
        @options[:clean_up] = true
      end

      opts.on("-n NUM_FILES", "--num-files NUM_FILES", Integer) do |num_files|
        @options[:num_files] = num_files
      end

      opts.on("-h", "--help") do
        @options[:help] = true
      end

      opts.on("-l", "--list-converted") do
        @options[:list_converted] = true
      end

      opts.on("-w", "--wack") do
        @options[:wack] = true
      end
    end
    option_parser.parse!

  end

  def put_options
    @options
  end
end
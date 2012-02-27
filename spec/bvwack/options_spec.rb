require "rspec"
require_relative '../spec_helper'

describe GetOptions do
  before :each do
    #ARGV = ['-b foo/bar', '-w']
    #@options = GetOptions.new().put_options

  end
  describe "#put_options" do
    @switches = { ['-d'] => { :dry_run => true },
              ['-b foo/bar'] => { :base_dir => ' foo/bar' },
              ['-c'] => { :clean_up => true },
              ['-n5'] => { :num_files => 5 },
              ['-h'] => { :help => true },
              ['-l'] => { :list_converted => true},
              ['-w'] => { :wack => true } }
    @switches.each do |switch|
      it "options should be #{switch[0]} " do
        ARGV     = switch[0]
        @options = GetOptions.new().put_options
        @options.should == switch[1]
      end
    end
  end
end
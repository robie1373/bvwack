require "rspec"
require_relative '../spec_helper'

describe Limiter do
  describe "#set_limit" do
    describe "with -n option set" do
      before :each do
        @options      = { }
        option_parser = OptionParser.new do |opts|
          opts.on("-n NUM_FILES", "--num_files NUM_FILES") do |num_files|
            @options[:num_files] = num_files
          end
        end
        option_parser.parse!(['-n 6'])
        @num_files = Limiter.new(:options => @options)
      end
      it "should set the limit to index of 5 (6 files) when -n 6 is passed" do
        @num_files.set_limit.should == 5
      end
    end
    describe "with -n option unset" do
      before :each do
        @options   = { }
        @num_files = Limiter.new(:options => @options)
      end

      it "should set the limit to index of 2 (3 files) when -n is not passed" do
        @num_files.set_limit.should == 2
      end
    end
  end
end
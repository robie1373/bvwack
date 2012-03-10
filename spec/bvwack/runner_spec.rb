require "rspec"
require_relative '../spec_helper'

describe Runner do
  before :each do
    @options      = { }
    option_parser = OptionParser.new do |opts|
      opts.on("-b BASE_DIR", "--base-dir BASE_DIR") do |base_dir|
        @options[:base_dir] = base_dir
      end
    end
    option_parser.parse!(['-b foo/bar'])
    @spec_base_dir = SpecBaseDirs.new
    @spec_file_obj = SpecFileObj.new(spec_lists)
    #lister = double Lister
    @lister = Lister.new(:lists => spec_lists, :base_dir => @spec_base_dir, :file_obj => @spec_file_obj)
  end

  describe "#run" do

    #it "shows me @commands" do
    #  pending "for testing"
    #  @commands.should == [1]
    #end

    commands.each do |command|
      it "calls the #{command} class" do
        pending "find out how to test without running the actual classes"
        Dir.pwd
        Runner.new(:command => command, :options => @options).run.should == ""
      end
    end
  end
end
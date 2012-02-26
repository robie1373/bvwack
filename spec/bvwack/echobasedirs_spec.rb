require "rspec"
require_relative '../spec_helper'
require 'optparse'


describe EchoBaseDirs do

  describe "with -b option set" do
    before :each do
      @options      = { }
      option_parser = OptionParser.new do |opts|
        opts.on("-b BASE_DIR", "--base-dir BASE_DIR") do |base_dir|
          @options[:base_dir] = base_dir
        end
      end
      option_parser.parse!(['-b foo/bar'])
      @base_dir = EchoBaseDirs.new(:options => @options)
      #let(:output) { double('output').as_null_object }
    end

    #it "testing if @options looks right this is not a real test. Just me understanding if I set up the before :each correctly" do
    #  @options.should == { :base_dir => " foo/bar" }
    #end
    describe "#base_convert_dir" do
      it "should equal foo/bar when :base_dir is set" do
        @base_dir.base_convert_dir.should == " foo/bar"
      end
    end

    describe "#base_clean_dir" do
      it "should equal foo/bar/bvwack-back when :base_dir is set" do
        @base_dir.base_clean_dir.should == " foo/bar/bvwack-back"
      end
    end

    describe "#echo_base_dirs" do
      it "should puts the correct messages" do
        pending "figure out how should_receive works or another way to test this"
        output = double('output')
        @base_dir.echo_base_dirs
        output.should_receive(:echo_base_dirs).with("hello")
        #output.should_receive(:puts).with("\nOperating in foo/bar\nI will create foo/bar/bvwack-back to store converted files if you use clean-up.\n\n")
      end
    end
  end

  describe "with -b option unset" do
    before :each do
      @options      = { }
      option_parser = OptionParser.new do |opts|
        opts.on("-b BASE_DIR", "--base-dir BASE_DIR") do |base_dir|
          @options[:base_dir] = base_dir
        end
      end
      option_parser.parse!([])
      @base_dir = EchoBaseDirs.new(:options => @options)
    end

    describe "#base_dirs" do
      it "should return the value of DEFAULT_CONVERT_BASE_DIR" do
        @base_dir.base_convert_dir.should == DEFAULT_CONVERT_BASE_DIR
      end

    end

    describe "#base_clean_dir" do
      it "should return the value of DEFAULT_CLEAN_BASE_DIR" do
        @base_dir.base_clean_dir.should == DEFAULT_CLEAN_BASE_DIR
      end
    end

    describe "#echo_base_dirs" do
      it "should puts the correct messages" do
        pending "figure out how should_receive works or another way to test this"
        output = double('output')
        @base_dir.echo_base_dirs
        output.should_receive(:echo_base_dirs).with("hello")
        #output.should_receive(:puts).with("\nOperating in foo/bar\nI will create foo/bar/bvwack-back to store converted files if you use clean-up.\n\n")
      end
    end
  end
end


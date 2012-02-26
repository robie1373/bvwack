require "rspec"
require_relative '../spec_helper'
require 'optparse'


describe EchoBaseDirs do

  #describe Putter do
  #  describe "#start" do
  #    it "should say i put" do
  #      output = double('output')
  #      putter = Putter.new
  #      putter.start.should == "i put"
        #output.should_receive(:p).with('i put')

        #putter.start
      #end
    #end
  #end


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
        EchoBaseDirs.new(:options => @options).echo_base_dirs.should == "\nOperating in  foo/bar\nI will create #{ File.join(@options[:base_dir], "bvwack-back")} to store converted files if you use clean-up.\n\n"
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
        EchoBaseDirs.new(:options => @options).echo_base_dirs.should == "\nOperating in #{DEFAULT_CONVERT_BASE_DIR}\nI will create #{ DEFAULT_CLEAN_BASE_DIR} to store converted files if you use clean-up.\n\n"
      end
    end
  end
end


require "rspec"
require_relative '../spec_helper'

describe "constants" do

  it "DEFAULT_CONVERT_BASE_DIR should be pwd " do
    DEFAULT_CONVERT_BASE_DIR.should == ENV['PWD']
  end

  it "DEFAULT_CLEAN_BASE_DIR should be pwd/bvwack-back" do
    DEFAULT_CLEAN_BASE_DIR.should == File.join(ENV['PWD'], "bvwack-back")
  end

  it "DEFAULT_ITERATION_LIMIT should be a fixnum" do
    DEFAULT_ITERATION_LIMIT.should be_a(Fixnum)
  end

  it "DEFAULT_THREADS should be a fixnum" do
    DEFAULT_THREADS.should be_a(Fixnum)
  end

  it "FFMPEG_OPTS should be a string" do
    FFMPEG_OPTS.should be_a(String)
  end

  it "FFMPEG_OPTS should be long" do
    FFMPEG_OPTS.length.should be > 5
  end

  it "INPUT_FILE_FORMATS should be an array" do
    INPUT_FILE_FORMATS.should be_an(Array)
  end

  it "INPUT_FILE_FORMATS should have 2 or more entries" do
    INPUT_FILE_FORMATS.length.should be >= 2
  end
end
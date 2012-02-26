require "rspec"
require_relative '../spec_helper'

describe "constants" do

  it "DEFAULT_CONVERT_BASE_DIR should be pwd " do
    DEFAULT_CONVERT_BASE_DIR.should == ENV['PWD']
  end

  it "DEFAULT_CLEAN_BASE_DIR should be pwd/bvwack-back" do
    DEFAULT_CLEAN_BASE_DIR.should == File.join(ENV['PWD'], "bvwack-back")
  end

  it "DEFAULT_ITERATION_LIMIT should be 2" do
    DEFAULT_ITERATION_LIMIT.should be_a(Fixnum)
  end
end
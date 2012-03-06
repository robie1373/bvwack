require "rspec"
require_relative '../spec_helper'

describe FileListGetter do
  before :each do
    @base_dir = "../../test_vids"
  end
  describe "#get_all_files" do
    it "should list out all files in the test dir." do
      pending "this class needs to be fixed"
      FileListGetter.new.get_all_files.should == []
    end
  end

  describe "#get_original_files" do
    it "should do its thing"
  end

  describe "#get_converted_files" do
    it "should do its thing"
  end

  describe "#lists" do
    it "should do its thing"
  end


end
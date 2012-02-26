require "rspec"
require_relative '../spec_helper'

describe FileObj do
  before :each do
    @file_obj = FileObj.new(:lists => spec_lists)
  end

  describe "#dirname" do
    (spec_to_clean.length).times do
      it "should tell me the directory name" do
        @file_obj.dirname.should == "dir1"
      end
    end
  end

  describe "#filename" do
    it "should tell me the filename" do
      @file_obj.filename.should == "dir1/file2.mkv"
    end
  end

  describe "#path_to_file" do
    it "give me the path from PWD to the extension" do
      @file_obj.filename.should == "dir1/file2.mkv"
    end
  end

  describe "#key" do
    it "should tell me the key to use for indexing the hashes. will be the filename minus the extension" do
      @file_obj.key.should == "dir1/file2"
    end
  end
end
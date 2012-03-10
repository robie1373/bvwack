require "rspec"
require_relative '../spec_helper'

describe FileObj do
  before :each do
    @file_obj = FileObj.new(:lists => spec_lists)
  end

  describe "#dirname" do
    i = 0
    (spec_to_clean.length).times do
      it "should tell me the directory name" do
        @file_obj.dirname(i).should == spec_not_converted_dirs[i]
      end
      i += 1
    end
  end

  describe "#filename" do
    i = 0
    (spec_to_clean.length).times do
      it "should tell me the filename" do
        @file_obj.filename(i).should == spec_not_converted_files[spec_not_converted_files.keys[i]]
      end
      i += 1
    end
  end

  describe "#path_to_file" do
    i = 0
    (spec_to_clean.length).times do
      it "give me the path from PWD to the extension" do
        @file_obj.filename(i).should == spec_to_convert[i]
      end
      i += 1
    end
  end

  describe "#key" do
    i = 0
    (spec_to_clean.length).times do
      it "should tell me the key to use for indexing the hashes. will be the filename minus the extension" do
        @file_obj.key(i).should == spec_not_converted_files.keys[i]
      end
      i += 1
    end
  end
end
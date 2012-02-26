require "rspec"
require_relative '../spec_helper'

describe Cleaner do

  before :each do
    spec_file_obj = double(FileObj.new(:lists => spec_lists))
    spec_base_dirs = SpecBaseDirs.new
    @cleaner        = Cleaner.new(:lists => spec_lists, :file_obj => spec_file_obj, :base_dir => spec_base_dirs)
  end

  describe "#clean_up" do
    it "should write the clean_up command string to STDOUT" do
      pending "track down the issue with @cleaner"
      @cleaner.clean_up.should be_a(String)
    end

    it "tells me if spec_lists is in scope" do
      pending "to help track down the problem above. Not a real test."
      spec_lists[:not_converted_files].should == {}
    end
  end
end
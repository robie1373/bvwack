require "rspec"
require_relative '../spec_helper'

describe Cleaner do

  before :each do
    #@file_obj  = double(FileObj.new(:lists => spec_lists))
    @iteration = 0
    @file_obj  = SpecFileObj.new(spec_lists)
    @base_dirs = SpecBaseDirs.new
    @cleaner   = Cleaner.new(:file_obj => @file_obj, :base_dir => @base_dirs, :iteration => @iteration)
    @mv_string = %Q{mkdir -p "#{File.join(@base_dirs.base_clean_dir, @file_obj.dirname)}" && mv "#{@file_obj.filename} #{File.join(@base_dirs.base_clean_dir, @file_obj.filename)}"}

  end

  describe "#clean_up" do
    it "should write the clean_up command string to STDOUT" do
      #pending "the if test in the clean_up method needs to get an iteration somehow."
      #@cleaner.clean_up.should == `#{@mv_string}`
      @cleaner.clean_up.should == "I would have run clean_up\n\t#{@mv_string}"
    end

    #it "tells me if spec_lists is in scope" do
    #  pending "to help track down the problem above. Not a real test."
    #  spec_lists[:not_converted_files].should == { }
    #end
    #
    #it "tells me if spec_file_obj is working (not a real test)" do
    #  pending "to help track down problem above. not a real test."
    #  @file_obj.should == ""
    #end
    #
    #it "tells me if spec_base_dirs is working. Not a real test" do
    #  pending "to help track down the problem above. Not a real test."
    #  @base_dirs.base_clean_dir.should == ""
    #end
  end
end
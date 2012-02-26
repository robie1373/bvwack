require "rspec"
require_relative '../spec_helper'

describe DryCleaner do
  before :each do
    @file_obj  = SpecFileObj.new(spec_lists)
    @base_dirs = SpecBaseDirs.new
    @dry_cleaner   = DryCleaner.new(:lists => spec_lists, :file_obj => @file_obj, :base_dir => @base_dirs)
    @mv_string = %Q{mkdir -p "#{File.join(@base_dirs.base_clean_dir, @file_obj.dirname)}" && mv "#{@file_obj.filename} #{File.join(@base_dirs.base_clean_dir, @file_obj.filename)}"}
  end

  describe "#dry_clean_up" do
    it "should write a copy of the clean_up command to STDOUT" do
      @dry_cleaner.dry_clean_up.should == "#{@mv_string}\n\n"
    end
  end
end
require "rspec"
require_relative '../spec_helper'

describe DryWacker do
  before :each do
    @file_obj  = SpecFileObj.new(spec_lists)
    @base_dirs = SpecBaseDirs.new
  end

  describe "#dry_wack" do
    (0..spec_to_convert.length - 1).each do |iteration|
      it "should return the #{iteration}th item convert command in file_obj.path_to_file when iteration = #{iteration}" do
        ffmpeg_string = %Q{ffmpeg -i "#{@file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{@file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"}
        DryWacker.new(:lists => spec_lists, :file_obj => @file_obj, :iteration => iteration).dry_wack.should == "#{ffmpeg_string}\n\n"

      end
    end
  end
end

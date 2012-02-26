require "rspec"
require_relative '../spec_helper'

describe Wacker do

  before :each do
    @file_obj  = SpecFileObj.new(spec_lists)
    @base_dirs = SpecBaseDirs.new
  end

  describe "#wack" do
    (0..spec_to_convert.length - 1).each do |iteration|
      it "should return the #{iteration}th item convert command in file_obj.path_to_file when iteration = #{iteration}" do
        ffmpeg_string = %Q{ffmpeg -i "#{@file_obj.path_to_file(iteration)}" #{FFMPEG_OPTS} "#{@file_obj.path_to_file(iteration).gsub(/mkv$|avi$/, "ipad.mp4")}"}

        #Wacker.new(:lists => spec_lists, :file_obj => @file_obj, :iteration => iteration).wack.should == `#{ffmpeg_string}`
        Wacker.new(:lists => spec_lists, :file_obj => @file_obj, :iteration => iteration).wack.should == "I would have run\n\t#{ffmpeg_string}"
      end
    end
  end
end

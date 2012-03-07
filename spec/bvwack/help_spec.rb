require "rspec"
require_relative '../spec_helper'

describe Help do
  describe "#be_helpful" do
    it "should output a long string. Lets say over 20 char." do

      (p Help.new.be_helpful).length.should be > 20

    end
  end
end
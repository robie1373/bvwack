require 'rspec'
require_relative '../spec_helper'

describe Help do
  it "should return a version string" do
    BVWack::VERSION.should be_a(String)
  end
end
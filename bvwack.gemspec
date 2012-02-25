$LOAD_PATH.push File.expand_path("../lib/bvwack", __FILE__)
require "bvwack_version"

Gem::Specification.new do |s|
  s.name                  = "bvwack"
  s.version               = BVWack::VERSION
  s.platform              = Gem::Platform::RUBY
  s.authors               = ["Robie Lutsey"]
  s.email                 = ["robie 0x55D in dec at gmail dit com"]
  s.homepage              = ""
  s.summary               = %q{bvwack will wack it's way your pile of unconverted video files.'}
  s.description           = %q{Super simple utility to help you convert all your videos to iPad ready files.}
  s.requirements          = ['ffmpeg and a libx264-slow.ffpreset (possibly in your ~/.ffmpeg/ directory.) Google is your friend.']
  s.rubyforge_project     = "bvwack"
  s.required_ruby_version = '>=1.9'
  s.files                 = Dir['bin/**', 'lib/**', 'pkg/**', '*']
  s.executables           = ["bvwack"]
  s.has_rdoc              = false
end
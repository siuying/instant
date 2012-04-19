$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "instant/version"

Gem::Specification.new do |s|
  s.name = "instant"
  s.version = Instant::VERSION
  s.authors = ["Francis Chong"]
  s.email = ["francis@ignition.hk"]
  s.homepage = "https://github.com/siuying/instant"
  s.summary = %q{An experiment on real time visualize development tool.}
  s.description = %q{An experiment on real time visualize development tool, inspired by Bret Victor's Inventing on Principle talk and @ermau C# Implementation.}

  s.files = `git ls-files`.split("\n").reject {|f| f =~ /^(?:spec|views|public|lib\/instant\/sinatra)\// } # Ignore spec/views/sinatra files
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency "ruby2ruby", "~> 1.3.1"
  s.add_runtime_dependency "ruby_parser", "~> 2.3.1"
end
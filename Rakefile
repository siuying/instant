$LOAD_PATH << "lib"
require 'instant/version'
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('instant', Instant::VERSION) do |p|
  p.description    = "An experiment on real time visualize development tool."
  p.url            = "http://github.com/siuying/instant"
  p.author         = "Francis Chong"
  p.email          = "francis@ignition.hk"
  p.ignore_pattern = ["pkg/*", "spec/*", "views/*", "public/**/*", "lib/instant/sinatra/*", "Procfile"]
  p.development_dependencies = ["rspec ~>2.9.0", "rake ~>1.1", "echoe", "autotest", "pry"]
  p.runtime_dependencies = ['ruby2ruby ~>1.3.1', 'ruby_parser ~>2.3.1']
  p.retain_gemspec = true
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

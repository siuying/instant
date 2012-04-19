require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('instant', '0.0.1') do |p|
  p.description    = "Generate a unique token with Active Record."
  p.url            = "http://github.com/ryanb/uniquify"
  p.author         = "Ryan Bates"
  p.email          = "ryan@railscasts.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
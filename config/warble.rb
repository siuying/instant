# Warbler web application assembly configuration file
Warbler::Config.new do |config|
  config.features = %w(executable)
  config.dirs = %w(config lib views public)
  config.includes = FileList["config.ru", "Gemfile", "Gemfile.lock"]
  config.gem_excludes = [/^(test|spec)\//]

  config.jar_name = "instant"
  config.public_html = FileList["public/**/*"]

  config.webxml.jruby.compat.version = "1.9"
  config.webxml.rackup = File.read("config.ru")
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "instant"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francis Chong"]
  s.date = "2012-04-22"
  s.description = "An experiment on real time visualize development tool."
  s.email = "francis@ignition.hk"
  s.extra_rdoc_files = ["README.md", "lib/instant.rb", "lib/instant/context.rb", "lib/instant/processor.rb", "lib/instant/runner.rb", "lib/instant/version.rb"]
  s.files = ["Gemfile", "Manifest", "README.md", "Rakefile", "config.ru", "lib/instant.rb", "lib/instant/context.rb", "lib/instant/processor.rb", "lib/instant/runner.rb", "lib/instant/version.rb", "spec/instant/context_spec.rb", "spec/instant/processor_spec.rb", "spec/instant/runner_spec.rb", "instant.gemspec"]
  s.homepage = "http://github.com/siuying/instant"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Instant", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "instant"
  s.rubygems_version = "1.8.15"
  s.summary = "An experiment on real time visualize development tool."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby2ruby>, ["~> 1.3.1"])
      s.add_runtime_dependency(%q<ruby_parser>, ["~> 2.3.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.9.0"])
      s.add_development_dependency(%q<rake>, ["~> 1.1"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<ruby2ruby>, ["~> 1.3.1"])
      s.add_dependency(%q<ruby_parser>, ["~> 2.3.1"])
      s.add_dependency(%q<rspec>, ["~> 2.9.0"])
      s.add_dependency(%q<rake>, ["~> 1.1"])
      s.add_dependency(%q<echoe>, [">= 0"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby2ruby>, ["~> 1.3.1"])
    s.add_dependency(%q<ruby_parser>, ["~> 2.3.1"])
    s.add_dependency(%q<rspec>, ["~> 2.9.0"])
    s.add_dependency(%q<rake>, ["~> 1.1"])
    s.add_dependency(%q<echoe>, [">= 0"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end

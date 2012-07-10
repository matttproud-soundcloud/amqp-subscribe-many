# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amqp-subscribe-many}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{brendanhay}]
  s.date = %q{2012-07-10}
  s.description = %q{Codifies best practices and configuration when consuming from multiple AMQP brokers simultaneously}
  s.email = %q{brendan@soundcloud.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "Makefile",
    "README.md",
    "Rakefile",
    "amqp-subscribe-many.gemspec",
    "examples/consumer_processor.rb",
    "examples/duplex_processor.rb",
    "examples/producer_processor.rb",
    "examples/run",
    "lib/messaging.rb",
    "lib/messaging/client.rb",
    "lib/messaging/configuration.rb",
    "lib/messaging/consumer.rb",
    "lib/messaging/producer.rb",
    "test/client_test.rb",
    "test/configuration_test.rb",
    "test/consumer_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/brendanhay/amqp-subscribe-many}
  s.licenses = [%q{MPL}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.7}
  s.summary = %q{An implementation of the publish one, subscribe many pattern}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<amqp>, [">= 0.9.6"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 3.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<amqp>, [">= 0.9.6"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 3.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<amqp>, [">= 0.9.6"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 3.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

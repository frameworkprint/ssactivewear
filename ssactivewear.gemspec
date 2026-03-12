# frozen_string_literal: true

require_relative "lib/ssactivewear/version"

Gem::Specification.new do |spec|
  spec.name = "ssactivewear"
  spec.version = Ssactivewear::VERSION
  spec.authors = ["Nathan Williams"]
  spec.email = ["nathan@nathan.la"]

  spec.summary = "Ruby client for the S&S Activewear API"
  spec.description = "A Ruby wrapper for the S&S Activewear API, providing access to products, inventory, orders, and more."
  spec.homepage = "https://github.com/frameworkprint/ssactivewear"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/frameworkprint/ssactivewear"
  spec.metadata["changelog_uri"] = "https://github.com/frameworkprint/ssactivewear/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .standard.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
end

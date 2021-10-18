# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panchira/version'

Gem::Specification.new do |spec|
  spec.name          = 'panchira'
  spec.version       = Panchira::VERSION
  spec.authors       = ['kyp']
  spec.email         = ['kyp@kmc.gr.jp']

  spec.summary       = 'A parser for hentai websites'
  spec.description   = <<-TEXT
    Panchira allows you to parse attributes of hentais on some web platforms, such as Pixiv and DLSite.
    If you need card previews on hentai but can't get it with simply parsing metatags, then it is time for Panchira.
  TEXT
  spec.homepage      = 'https://github.com/nuita/panchira'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/nuita/panchira'
  spec.metadata['changelog_uri']   = 'https://github.com/nuita/panchira/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.10'

  spec.add_dependency 'fastimage', '~> 2.1.7'
  spec.add_dependency 'nokogiri', '>= 1.10.9', '< 1.12.0'
  spec.add_dependency 'twitter-text', '~>3.1.0'
end

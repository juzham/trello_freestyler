# frozen_string_literal: true

require_relative 'lib/trello_freestyler/version'

Gem::Specification.new do |spec|
  spec.name          = 'trello_freestyler'
  spec.version       = TrelloFreestyler::VERSION
  spec.authors       = ['Justin Hamman']
  spec.email         = ['justinhamman@gmail.com']

  spec.summary       = 'Uses the Trello API to dump json line files for a Trello board and its actions.'
  spec.description   = 'Built so trello data can be easily ingested into BigQuery.'
  spec.homepage      = 'https://rubygems.org/gems/trello_freestyler'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/juzham/trello_freestyler'
  spec.metadata['changelog_uri'] = 'https://github.com/juzham/trello_freestyler/CHANGELOG.md'

  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'tty-spinner'
  spec.add_runtime_dependency 'tzinfo'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-emoji'
  spec.add_development_dependency 'rubocop-rspec'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end

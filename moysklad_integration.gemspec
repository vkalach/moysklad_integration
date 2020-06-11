# frozen_string_literal: true

require_relative 'lib/moysklad_integration/version'

Gem::Specification.new do |spec|
  spec.name          = 'moysklad_integration'
  spec.version       = MoyskladIntegration::VERSION
  spec.authors       = ['Vladislav Kalach']
  spec.email         = ['kalach.vladislav@gmail.com']
  spec.summary       = 'Moysklad Integration.'
  spec.description   = 'Gem for easier integration ruby and moysklad.ru'
  spec.homepage      = 'https://github.com/vkalach/moysklad_integration'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/vkalach/moysklad_integration'
  spec.metadata['changelog_uri'] = 'https://github.com/vkalach/moysklad_integration/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.0', '>= 6.0.3.1'
  spec.add_dependency 'faraday', '~> 1.0', '>= 1.0.1'
  spec.add_dependency 'addressable', '~> 2.7'
  spec.add_dependency 'log4r', '~> 1.1', '>= 1.1.10'
end

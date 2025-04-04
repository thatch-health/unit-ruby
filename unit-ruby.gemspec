lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unit-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'unit-ruby'
  spec.version       = Unit::VERSION
  spec.authors       = ['Chloe Isacke', 'Ian Yamey']
  spec.email         = ['chloe@retirable.com', 'ian@retirable.com']

  spec.summary       = 'A Ruby gem for communicating with the Unit API.'
  spec.homepage      = 'https://github.com/retirable/unit-ruby'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/retirable/unit-ruby'
    spec.metadata['changelog_uri'] = 'https://github.com/retirable/unit-ruby/blob/main/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'faraday', '>= 1.10', '< 3'
  spec.add_dependency 'faraday-retry'

  spec.add_development_dependency 'dotenv', '~> 2.7.6'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.24.1'
  spec.metadata['rubygems_mfa_required'] = 'true'
end

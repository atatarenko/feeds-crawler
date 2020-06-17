lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'feeds-crawler'
  spec.version       = '0.2.1'
  spec.authors       = ['Andrey Tatarenko']
  spec.email         = ['andrey17076@gmail.com']

  spec.summary       = 'This gem allows to crawl news articles from RSS feeds.'
  spec.homepage      = 'https://github.com/andrey17076/feed-crawler'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'rubocop', '~> 0.54'

  spec.add_runtime_dependency 'parallel', '~> 1.12', '>= 1.12.0'
  spec.add_runtime_dependency 'ruby-readability', '~> 0.7', '>= 0.7.0'
  spec.add_runtime_dependency 'sanitize', '>= 4.5.0', '< 6.0'
end


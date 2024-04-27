require_relative 'lib/appium_thor/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.0'

  s.name          = 'appium_thor'
  s.version       = Appium::Thor::VERSION
  s.date          = Appium::Thor::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Thor tasks for Appium gems.'
  s.authors       = s.email = ['code@bootstraponline.com']
  s.homepage      = 'https://github.com/appium/appium_thor'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'redcarpet', '~> 3.1', '>= 3.1.2'

  s.files = `git ls-files`.split "\n"
end

require_relative 'lib/appium_thor/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.1'

  s.name          = 'appium_thor'
  s.version       = Appium::Thor::VERSION
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Thor tasks for Appium gems.'
  s.authors       = ['code@bootstraponline.com', 'Kazuaki Matsuo']
  s.email         = %w(code@bootstraponline.com fly.49.89.over@gmail.com)
  s.homepage      = 'https://github.com/appium/appium_thor'
  s.require_paths = ['lib']

  s.add_dependency 'thor', '>= 0.19', '< 2.0'

  s.files = `git ls-files`.split "\n"
end

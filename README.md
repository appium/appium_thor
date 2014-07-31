# appium_thor [![Gem Version](https://badge.fury.io/rb/appium_thor.svg)](http://badge.fury.io/rb/appium_thor)[![Dependency Status](https://gemnasium.com/appium/appium_thor.svg)](https://gemnasium.com/appium/appium_thor)


Appium Thor helpers for appium's gems (appium_lib, appium_capybara)

--

Example configuration

```ruby
Appium::Thor::Config.set do
  gem_name 'appium_lib'
  github_name 'ruby_lib'
  version_file 'path/to/version.rb'
end
```

Available tasks

```
thor build          # Build a new gem
thor bump           # Bump the z version number and update the date.
thor bumpx          # Bump the x version number, set y & z to zero, update the date.
thor bumpy          # Bump the y version number, set z to zero, update the date.
thor byte           # Remove non-ascii bytes from all *.rb files in the current dir
thor docs           # Update android and iOS docs
thor gem_install    # Install gem
thor gem_uninstall  # Uninstall gem
thor info           # prints config info for this gem
thor notes          # Update release notes
thor publish        # Build and release a new gem to rubygems.org
thor release        # Build and release a new gem to rubygems.org (same as publish)
```

Note to see gem warnings, run `gem build appium_thor.gemspec` and replace `appium_thor.gemspec` with the gemspec of your gem.

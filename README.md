# appium_thor [![Gem Version](https://badge.fury.io/rb/appium_thor.svg)](http://badge.fury.io/rb/appium_thor)[![Dependency Status](https://gemnasium.com/appium/appium_thor.svg)](https://gemnasium.com/appium/appium_thor)


Appium Thor helpers for appium's gems (appium_lib, appium_capybara).

--

# Example configuration

```ruby
Appium::Thor::Config.set do
  gem_name     'appium_thor'
  github_name  'appium_thor'
  version_file 'lib/appium_thor/version.rb'
  docs_block do
    run 'docs/helpers_docs.md', globs('/lib/appium_thor/helpers.rb')
  end
end
```

--

# Available tasks

Note to see gem warnings, run `gem build appium_thor.gemspec` and replace `appium_thor.gemspec` with the gemspec of your gem.

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

--

# docs_block

The `docs_block` method runs within the `docs.rb` context. Here's a more complex example:

```ruby
common_globs  = '/lib/appium_lib/*.rb', '/lib/appium_lib/device/*.rb', '/lib/appium_lib/common/**/*.rb'
android_globs = common_globs + ['/lib/appium_lib/android/**/*.rb']
ios_globs     = common_globs + ['/lib/appium_lib/ios/**/*.rb']

run 'docs/android_docs.md', globs(android_globs)

run 'docs/ios_docs.md', globs(ios_globs)
```
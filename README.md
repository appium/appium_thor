# appium_thor

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
thor build      # Build a new gem (same as gem task)
thor bump       # Bump the z version number and update the date
thor bumpx      # Bump the x version number, set y & z to zero, update the ...
thor bumpy      # Bump the y version number, set z to zero, update the date
thor byte       # Remove non-ascii bytes
thor dev        # Install gems required for release task
thor docs       # Update android and iOS docs
thor gem        # Build a new gem
thor install    # Install gem
thor notes      # Update release notes
thor publish    # Build and release a new gem to rubygems.org (same as rele...
thor release    # Build and release a new gem to rubygems.org
thor uninstall  # Uninstall gem
```
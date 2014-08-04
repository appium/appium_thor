require File.expand_path '../lib/appium_thor', __FILE__

Appium::Thor::Config.set do
  appium_thor = 'appium_thor'
  gem_name     appium_thor
  docs_block do
    run 'docs/helpers_docs.md', globs("/lib/#{appium_thor}/helpers.rb")
  end
end
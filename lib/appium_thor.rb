# stdlib
require 'forwardable' # commands.rb
require 'singleton'   # config.rb
require 'fileutils'
require 'open3'

# gems
require 'rubygems'
require 'date'        # helpers.rb Date.today

# internal
require_relative 'appium_thor/helpers'
require_relative 'appium_thor/version'
require_relative 'appium_thor/config'
require_relative 'appium_thor/commands/init'
require_relative 'appium_thor/commands/commands'
# stdlib

require 'forwardable' # commands.rb
require 'singleton'   # config.rb

# gems
require 'rubygems'
require 'yard'
require 'posix-spawn'
require 'date'

require_relative 'appium_thor/docs'
require_relative 'appium_thor/helpers'
require_relative 'appium_thor/version'

require_relative 'appium_thor/config'
require_relative 'appium_thor/commands/commands'
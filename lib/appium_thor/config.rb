module Appium
  module Thor
    class Config
      include Singleton

      # Returns true if all options are truthy
      def validate
        raise 'Must set gem_name, github_name, version_file' unless @gem_name && @github_name && @version_file
        raise "version file doesn't exist #{@version_file}" unless File.exist?(@version_file)
      end

      # Returns option value if it's set otherwise
      # sets the option value to string
      def gem_name string=nil
        return @gem_name if @gem_name
        @gem_name = string
      end

      # Returns option value if it's set otherwise
      # sets the option value to string
      def github_name string=nil
        return @github_name if @github_name
        @github_name = string
      end

      # Returns option value if it's set otherwise
      # sets the option value to string
      def version_file string=nil
        return @version_file if @version_file
        @version_file = string
      end

      # block of code to execute that contains documentation
      # generation logic
      def docs_block &block
        return @docs_block if @docs_block
        @docs_block = block
      end

      # all config.rb options as a symbol array
      def self.options
        %w[gem_name github_name version_file docs_block].map(&:to_sym)
      end

      # Enables setting config in the Thorfile
      #
      # Appium::Thor::Config.set do
      #   gem_name     'appium_thor'
      #   github_name  'appium_thor'
      #   version_file 'path/to/version.rb'
      # end
      def self.set &block
        config = self.instance
        config.instance_eval &block
        config.validate
        config
      end
    end # module Config
  end # module Thor
end # module Appium
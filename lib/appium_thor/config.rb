module Appium
  module Thor
    class Config
      include Singleton

      # Returns true if all options are truthy
      def init_and_validate
        # set default values
        if @gem_name
          @github_name  ||= @gem_name
          @version_file ||= "lib/#{@gem_name}/version.rb"
        end

        @branch ||= 'master'

        @github_owner ||= 'appium'

        # ensure all options are set
        all_set = @gem_name && @github_name && @github_owner && @version_file
        raise 'Must set gem_name, github_name, github_owner, version_file' unless all_set
        raise "version file doesn't exist #{@version_file}" unless File.exist?(@version_file)
      end

      # Returns all options as symbols. Required for defining delegators in init.rb
      def self.options
        string_options
      end

      # the subset of options that operate on strings
      def self.string_options
        %w[gem_name github_name github_owner branch version_file].map(&:to_sym)
      end

      string_options.each do |option|
        class_eval %Q(
         def #{option} string=nil
          return @#{option} if @#{option}
          @#{option} = string
         end
        )
      end

      # Enables setting config in the Thorfile
      #
      # Appium::Thor::Config.set do
      #   gem_name     'appium_thor'
      #   github_owner 'appium'
      #   github_name  'appium_thor'
      #        branch  'master'
      #   version_file 'path/to/version.rb'
      # end
      def self.set(&block)
        config = self.instance
        config.instance_eval &block
        config.init_and_validate
        config
      end
    end # module Config
  end # module Thor
end # module Appium
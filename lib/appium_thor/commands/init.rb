# Define Thor tasks in the top level Default namespace.
class Default < Thor
  extend Forwardable
  include Appium::Thor::Helpers

  # For each possible option method, delegate calls to the config instance
  no_commands do
    def_delegators(:@cfg, *Appium::Thor::Config.options)
  end

  def initialize(args = [], options = {}, config = {})
    super
    # Aquire reference to the config defined in the Thorfile
    @cfg = Appium::Thor::Config.instance
  end
end
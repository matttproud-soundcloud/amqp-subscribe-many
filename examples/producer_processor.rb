require "messaging"

# A publish only example
class ProducerProcessor
  include Messaging::Producer

  attr_reader :config

  # @param config [Messaging::Configuration].
  def initialize(config)
    @config = config
  end
end

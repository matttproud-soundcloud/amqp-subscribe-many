require "messaging"

# A consume only example
class ConsumerProcessor
  include Messaging::Consumer

  attr_reader :config

  # @param config [Messaging::Configuration].
  def initialize(config)
    @config = config
  end

  subscribe("exchange", "direct", "queue", "key")

  def on_message(meta, payload)
    log.info("ConsumeProcessor channel #{meta.channel.id} received payload #{payload.inspect}")
  end
end

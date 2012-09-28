require "logger"

module Messaging

  # Global configuration for producer and consumer mixins.
  class Configuration
    # Set-up an instance of [Messaging::Configuration].
    # @yieldparam [Messaging::Configuration] an empty configuration with
    #             basic defaults.
    # @api public
    def self.setup(&block)
      configuration = Configuration.new
      yield(configuration)
      configuration.freeze
    end

    # Please explicitly set this to your publishing endpoint.
    #
    # @!attribute [r] publish_to
    #   @return [String]
    attr_accessor :publish_to

    # Please explicitly set this to your consumption endpoint.
    #
    # @!attribute [r] consume_from
    #   @return [Array<String>]
    attr_accessor :consume_from

    # @!attribute [r] prefetch
    #   @return [Integer]
    attr_accessor :prefetch

    # @!attribute [r] exchange_options
    #   @return [Hash]
    attr_accessor :exchange_options

    # @!attribute [r] queue_options
    #   @return [Hash]
    attr_accessor :queue_options

    # @!attribute [r] reconnect_delay
    #   @return [Integer]
    attr_accessor :reconnect_delay

    # @!attribute [r] logger
    #   @return [#info, #debug, #error]
    attr_accessor :logger

    private

    # @api private
    def initialize
      @publish_to       = nil
      @consume_from     = []
      @prefetch         = 1
      @exchange_options = { :auto_delete => false, :durable => true }
      @queue_options    = exchange_options
      @reconnect_delay  = 5
      @logger           = Logger.new(STDOUT)
    end
  end

end

module Messaging

  module Producer
    include Client

    # Publish a payload to the specified exchange/key pair.
    #
    # @param exchange [String]
    # @param type [String]
    # @param key [String]
    # @param payload [Object]
    # @return [Messaging::Producer]
    # @api public
    def publish(exchange, type, key, payload, options = {})
      ex = producer_exchanges[exchange] ||=
        declare_exchange(producer_channel, exchange, type, config.exchange_options)

      log.debug("Publishing to exchange #{exchange.inspect} via #{key.inspect}")

      ex.publish(payload, options.merge({
        :exchange    => exchange,
        :routing_key => key
      }))

      self
    end

    # Close the channel and then disconnect the connection.
    #
    # @return []
    # @api public
    def disconnect
      producer_channel.close do |close_ok|
        producer_connection.disconnect
      end
    end

    private

    # @return [Hash(String, AMQP::Exchange)]
    # @api private
    def producer_exchanges
      @producer_exchanges ||= {}
    end

    # @return [AMQP::Connection]
    # @api private
    def producer_connection
      @producer_connection ||= open_connection(config.publish_to)
    end

    # @return [AMQP::Channel]
    # @api private
    def producer_channel
      @producer_channel ||= open_channel(producer_connection)
    end
  end

end

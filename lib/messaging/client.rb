require "amqp"

module Messaging

  #
  # Provides methods and constants required to establish an AMQP
  # connection and channel with failure handling and recovery.
  #
  module Client

    # Declare an exchange on the specified channel.
    #
    # @param channel [AMQP::Channel]
    # @param name [String]
    # @param type [String]
    # @param options [Hash]
    # @return [AMQP::Exchange]
    # @api public
    def declare_exchange(channel, name, type, options = {})
      exchange =
        # Check if default options need to be supplied to a non-default delcaration
        if default_exchange?(name)
          channel.default_exchange
        else
          channel.send(type, name, options)
        end

      puts "Exchange #{exchange.name.inspect} declared"

      exchange
    end

    # Declare and bind a queue to the specified exchange via the
    # supplied routing key.
    #
    # @param channel [AMQP::Channel]
    # @param exchange [AMQP::Exchange]
    # @param name [String]
    # @param key [String]
    # @param options [Hash]
    # @return [AMQP::Queue]
    # @api public
    def declare_queue(channel, exchange, name, key, options = {})
      channel.queue(name, options) do |queue|
        # Check if additional bindings are needed
        unless default_exchange?(exchange.name)
          queue.bind(exchange, { :routing_key => key })
        end

        puts "Queue #{queue.name.inspect} bound to #{exchange.name.inspect}"
      end
    end

    protected

    #
    #
    # @return [Messaging::Configuration]
    # @api protected
    def config
      Configuration.instance
    end

    # Create an AMQP::Connection with auto-reconnect and error handling.
    #
    # @param uri [String] The AMQP URI to connect to.
    # @param delay [Integer, nil] Time to delay between reconnection attempts.
    # @return [AMQP::Connection]
    # @api protected
    def open_connection(uri, delay = nil)
      delay ||= config.reconnect_delay
      options = AMQP::Client.parse_connection_uri(uri)

      AMQP.connect(options) do |connection, open_ok|
        # Handle TCP connection errors
        connection.on_tcp_connection_loss do |conn, settings|
          puts "Connection to #{uri.inspect} lost, reconnecting"

          conn.periodically_reconnect(delay)
        end

        # Handle general errors
        connection.on_error do |conn, error|
          puts "Connection to #{uri.inspect} lost, reconnecting"

          conn.periodically_reconnect(delay)
        end

        puts "Connection to #{uri.inspect} started"
      end
    end

    # Open an AMQP::Channel with auto-recovery and error handling.
    #
    # @param connection [AMQP::Connection]
    # @param prefetch [Integer, nil]
    # @return [AMQP::Channel]
    # @api protected
    def open_channel(connection, prefetch = nil)
      AMQP::Channel.new(connection) do |channel, open_ok|
        channel.auto_recovery = true
        channel.prefetch(prefetch) if prefetch

        channel.on_error do |ch, error|
          puts "Channel error #{error.reply_text.inspect}, recovering"
        end

        puts "Channel #{channel.id} created"
      end
    end

    private

    # @param name [String]
    # @return [Boolean]
    # @api private
    def default_exchange?(name)
      ["amq.direct",
       "amq.fanout",
       "amq.topic",
       "amqp.headers",
       "amqp.match"].include?(name)
    end
  end

end

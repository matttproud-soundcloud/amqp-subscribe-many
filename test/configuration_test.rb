require_relative "test_helper"

class ConfigurationTest < MiniTest::Unit::TestCase
  def setup
    @config = Messaging::Configuration.new
  end

  def test_publish_to
    expected = "ballsacks"
    @config = Messaging::Configuration.setup { |c| c.publish_to = expected }

    assert_equal(expected, @config.publish_to)
  end

  def test_consume_from
    expected = "nutsacks"
    @config = Messaging::Configuration.setup { |c| c.consume_from = expected }

    assert_equal(expected, @config.consume_from)
  end

  def test_prefetch
    assert(@config.prefetch > 0)

    expected = 7
    @config = Messaging::Configuration.setup { |c| c.prefetch = expected }

    assert_equal(expected, @config.prefetch)
  end

  def test_exchange_options
    assert(@config.exchange_options)

    expected = { :nonsense => true }
    @config = Messaging::Configuration.setup { |c| c.exchange_options = expected }

    assert_equal(expected, @config.exchange_options)
  end

  def test_queue_options
    assert(@config.queue_options)

    expected = { :high_five => "ok!" }
    @config = Messaging::Configuration.setup { |c| c.queue_options = expected }

    assert_equal(expected, @config.queue_options)
  end

  def test_reconnect_delay
    assert(@config.reconnect_delay > 0)

    expected = 12
    @config = Messaging::Configuration.setup { |c| c.reconnect_delay = expected }

    assert_equal(expected, @config.reconnect_delay)
  end

  def test_logger
    assert(@config.logger)

    expected = "ballsacks"
    @config = Messaging::Configuration.setup { |c| c.logger = expected }

    assert_equal(expected, @config.logger)
  end
end

require_relative "storage/base_storage"
# require "server"
require "test/unit"
require "socket"
require 'json'
require_relative 'yakvd_constants'

class TestYacd < Test::Unit::TestCase

  def _test_template(
    query_hash,
    allowed_response,
    error_text,
    inverse = false
  )
    s = TCPSocket.new('127.0.0.1', 2000)

    s.print("test\r\n")
    s.print("\r\n")
    s.print(
      query_hash.to_json + "\r\n"
    )
    response = s.gets("\r\n")
    if inverse
      assert_not_equal(allowed_response, response, error_text)
    else
      assert_equal(allowed_response, response, error_text)
    end

    s.close
  end

  def test_set_value
    query_hash = {
      query: {
        command: 'set_value',
        key: 'programmer-1',
        value: 'Khalikov Ruslan'
      }
    }
    _test_template(query_hash, YakvdConstants.success, "set value is broken")
  end

  def test_get_value
    query_hash = {
      query: {
        command: 'get_by_key',
        key: 'programmer-3'
      }
    }
    _test_template(query_hash, "Another Programmer", "get value is broken (2)")
  end

  def test_get_default
    query_hash = {
      query: {
        command: 'get_by_key',
        key: 'programmer-2'
      }
    }
    _test_template(query_hash, YakvdConstants.key_not_found, "get by key is broken")
  end

  def test_get_time
    query_hash = {
        query: {
            command: 'get_time'
        }
    }
    _test_template(query_hash, YakvdConstants.default, "get time is broken", true)
  end

  def test_get_range
    query_hash = {
      query: {
        command: 'get_range',
        key1: 'programmer-3',
        key2: 'programmer-5'
      }
    }
    _test_template(query_hash, '["programmer-3", "programmer-4", "programmer-5"]', "get range is broken")
  end

end
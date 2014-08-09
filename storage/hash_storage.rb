# Key-Value Database hash storage

require_relative 'base_storage'
require 'yakvd_constants'

class HashStorage < BaseStorage

  # Using ruby hash to store values in RAM
  def initialize(config)
    @store_ = {}
    super(config)
  end

  # Get value by key
  # Params:
  # * key
  # Returns:
  # value or `YakvdConstants.key_not_found`
  def get_by_key(key)
    @store_[key] || YakvdConstants.key_not_found
  end

  # Set value, associated with a key
  # Params:
  # * key
  # * value
  # Returns:
  # `YakvdConstants.success`
  def set_value(key, value)
    @store_[key] = value
    YakvdConstants.success
  end

  # Get line from file on disk and store it to RAM
  def store(line)
    line_list = (line.strip).split(YakvdConstants.delimiter)
    k = line_list[0]
    v = line_list[1]
    @store_[k] = v
  end

end
# Balanced tree storage for Key-Value Database

require 'binary_search_tree'
require 'binary_search_tree_hash'
require 'json'
require_relative 'btree'
require_relative 'base_storage'
require_relative '../yakvd_constants'

class BtreeStorage < BaseStorage

  # Using binary search tree to store values in RAM
  def initialize(config)
    @store_ = BinarySearchTreeHash.new
    super(config)
  end

  # Get value by key.
  # Params:
  # * key
  # Returns:
  # value or `YakvdConstants.key_not_found`
  def get_by_key(key)
    @store_[key] || YakvdConstants.key_not_found
  end

  # Get array of keys between `key1` and `key2`
  def get_range(key1, key2)
    @store_.get_range(key1, key2)
  end

  # Set value, associated with a key.
  # Params:
  # * key
  # * value
  # Returns:
  # `YakvdConstants.success`
  def set_value(key, value)
    @store_[key] = value
    YakvdConstants.success
  end

  # Get line from file on disk and store it to RAM.
  # Params:
  # *line
  def store(line)
    line_list = (line.strip).split(YakvdConstants.delimiter)
    k = line_list[0]
    v = line_list[1]
    @store_[k] = v
  end

end
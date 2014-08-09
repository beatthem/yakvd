# Response class. Implements basic operations with database

class QueryResponse < Object
  def initialize(storage)
    @storage = storage
  end

  # Get value by key
  # if there is no key, returns default
  def get_by_key(params)
    key = params['key']
    if key
      @storage.get_by_key key
    else
      self.get_default
    end
  end

  # Set value by key
  # if there is no key, returns default
  def set_value(params)
    key = params['key']
    value = params['value']
    if key
      @storage.set_value(key, value)
    else
      self.get_default
    end
  end

  # Returns Server Time
  def get_time(params)
    Time.now
  end

  # Returns json with pairs Key-Value for keys in range
  # Implemented in BtreeStorage
  def get_range(params)
    key1 = params['key1']
    key2 = params['key2']
    if key1 && key2 && @storage.respond_to?('get_range')
      @storage.get_range(key1, key2)
    else
      get_default
    end
  end

  # Returns default response
  def get_default()
    YakvdConstants.default
  end
end
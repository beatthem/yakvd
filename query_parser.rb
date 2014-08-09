# Basic query parser for Key-Value database


class QueryParser < Object
  def initialize(response_obj)
    @response_obj = response_obj
  end

  # Read commands from `query` and invokes it on QueryResponse's instance
  def parse(query)
    command = query['command']
    params = query
    if command && command != 'get_default' && @response_obj.respond_to?(command)
      @response_obj.send(command, params)
    else
      @response_obj.get_default
    end
  end
end

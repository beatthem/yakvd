# This program is the simple implementation of Key-Value Database
# It starts TCPServer and waits for requests from client applications

require 'json'
require 'socket'
require_relative 'query_parser'
require_relative 'query_response'
require_relative 'yakvd_config'
require_relative 'yakvd_utils'

require_relative "storage/#{underscore(YakvdConfig.yakvd_config[:storage_name])}"

# Starting server and waiting for requests
def run
  config = YakvdConfig.yakvd_config
  config[:storage] = Kernel.const_get(config[:storage_name])

  storage = config[:storage].new(config)
  response_obj = QueryResponse.new(storage)
  query_parser = QueryParser.new(response_obj)

  server = TCPServer.new('', 2000)
  loop {
    connection = server.accept
    while true
      header_line = connection.gets "\r\n"
      p header_line
      #TODO: there must be header_line == '\r\n' or header_line == "\r\n"
      # or header_line.equal?('\r\n')
      # but it doesn't work
      if header_line.length == 2
        break
      end
    end
    message = connection.gets "\r\n"
    p message.strip
    message_hash = JSON.parse(message.strip)
    query_hash = message_hash['query']
    response = query_parser.parse(query_hash)
    req_response = response
    connection.write(req_response)
    connection.close
  }
end

if __FILE__ == $0
  run
end
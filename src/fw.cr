require "./fw/*"

module Fw
  def self.run(host = "0.0.0.0", port = 7777)
    server = HTTP::Server.new(host, port, Fw::ServerHandler::INSTANCE)
    server.listen
  end
end

require "http/server"

module Fw
  module Handler
    abstract def call(ctx : HTTP::Server::Context, done : HTTP::Server::Context -> (HTTP::Server::Context | String | Int32 | Int64 | Bool | Nil))
  end
end

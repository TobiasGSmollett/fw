require "http"
require "./*"
require "radix"

module Fw
  class ServerHandler
    include HTTP::Handler
    
    INSTANCE = new
    
    private def initialize
      @tree = Radix::Tree(Fw::Stack).new
    end
    
    def add_stack(method, path, stack)
      lookup_result = @tree.find "/#{method.downcase}#{path}"
      raise "There is already an existing path for #{method.upcase} #{path}." if lookup_result.found?
      @tree.add "/#{method.downcase}#{path}", stack
      @tree.add("/head#{path}", Fw::Stack.new([] of Fw::Handler) { |ctx| "" }) if method == "GET"
    end
    
    def call(ctx)
      # パスが定義されているかのチェック
      node = "/#{ctx.request.method.downcase}#{ctx.request.path}"
      lookup_result = @tree.find node
      raise Fw::RouteNotFound.new(ctx) unless lookup_result.found?

      # run the stack
      stack = lookup_result.payload.as(Fw::Stack)
      content = stack.run ctx
    ensure
      ctx.response.print content
    end
  end
end
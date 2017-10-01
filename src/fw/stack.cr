require "./*"

module Fw
  class Stack    
    def initialize(@middlewares : Array(Handler), &@block : HTTP::Server::Context -> (HTTP::Server::Context | String | Int32 | Int64 | Bool | Nil))
    end
    
    def run(ctx : HTTP::Server::Context)
      self.next(0, ctx)
    end
    
    def next(index : Int32, ctx : HTTP::Server::Context)
      if mw = @middlewares[index]?
        mw.call ctx, ->{ self.next(index + 1, ctx) }
      elsif block = @block
        block.call(ctx)
      else
        raise Fw::RouteNotFound.new(ctx)
      end
    end
  end
end

module Fw
  class RouteNotFound < Exception
    def initialize(ctx)
      super "Requested path: '#{ctx.request.method.to_s}:#{ctx.request.path}' was not found."
    end
  end
end
require "./*"

HTTP_METHODS_OPTIONS = %w(get post put patch delete options)

{% for method in HTTP_METHODS_OPTIONS %}
  def {{method.id}}(path, &block : HTTP::Server::Context -> (HTTP::Server::Context|String|Int32|Int64|Bool|Nil))
    stack = Fw::Stack.new([] of Fw::Handler, &block)
    Fw::ServerHandler::INSTANCE.add_stack {{method}}.upcase, path, stack
  end

  def {{method.id}}(path, middlewares : Array(Fw::Handler), &block : HTTP::Server::Context -> (HTTP::Server::Context|String|Int32|Int64|Bool|Nil))
    stack = Fw::Stack.new(middlewares, &block)
    Fw::ServerHandler::INSTANCE.add_stack {{method}}.upcase, path, stack
  end
{% end %}
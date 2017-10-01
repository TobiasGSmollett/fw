require "./fw"

get "/hello" do |ctx|
  "hello, world!"
end

Fw.run
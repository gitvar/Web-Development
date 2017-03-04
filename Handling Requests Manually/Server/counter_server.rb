require "socket"

def parse(request_line)
  http_method, path_and_params, _http_part = request_line.split(" ")
  path, params = path_and_params.split("?")
  params = (params || "").split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end
  [http_method, path, params]
end

server = TCPServer.new("localhost", 3004)
loop do
  client = server.accept

  request_line = client.gets
  next unless request_line || request_line =~ /favicon/

  http_method, path, params = parse(request_line)

  # Proper HTTP Response:
  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts request_line
  client.puts "</pre>"

  puts request_line
  puts http_method
  puts path
  puts params

  number = params["number"].to_i

  client.puts "<h1>Counter</h1>"
  client.puts "<p>The current number is #{number}.</p>"
  client.puts
  client.puts "<p><a href='?number=#{number + 1}'>Add one</a></p>"
  client.puts "<p><a href='?number=#{number - 1}'>Delete one</a></p>"
  client.puts "</body>"
  client.puts "</html>"
  client.close
end

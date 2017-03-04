require "socket"

def parse(request_line)
  http_method, path_and_params, _http_part = request_line.split(" ")
  path, params = path_and_params.split("?")
  params = params.split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end
  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next unless request_line || request_line =~ /favicon/

  # What we need to extract in the "parse" method:
  # "GET /?rolls=2&sides=6 HTTP/1.1"
  # http_method == "GET"
  # path == "/"
  # params = { "rolls" => "2", "sides" => "6" }

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

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  client.puts "<h1>Rolls!</h1>"
  rolls.times do
    die_value = rand(sides) + 1
    puts die_value
    client.puts "<p>", die_value, "</p>"
  end

  client.puts "</body>"
  client.puts "</html>"
  client.close
end

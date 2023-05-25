require 'socket'

server = TCPServer.new('0.0.0.0', 2003)

loop do
  client = server.accept
  request = ""
  while (line = client.gets) && !line.chomp.empty?
    request += line
  end

  # Extract the request path and query parameters
  path, query = request.split(' ')[1].split('?')
  path = path.sub('/', '')

  if path == 'login'
    password = query.split('=')[1].gsub(/%22/, '') # Extract the password from the query parameters
    # Compare the password with a stored value (e.g., stored_password)
    stored_password = '1234' # Replace with the actual stored password
    if password == stored_password
      response = "HTTP/1.1 200 OK\r\n"
      response += "Content-Type: text/html\r\n"
      response += "\r\n"
      response += "<html><body><h1>Success</h1></body></html>\r\n"
    else
      response = "HTTP/1.1 200 OK\r\n"
      response += "Content-Type: text/html\r\n"
      response += "\r\n"
      response += "<html><body><h1>Invalid</h1></body></html>\r\n"
    end
  elsif path == 'sayhello'
    name = query.split('=')[1].gsub(/%22/, '') # Extract the name from the query parameters
    response = "HTTP/1.1 200 OK\r\n"
    response += "Content-Type: text/html\r\n"
    response += "\r\n"
    response += "<html><body><h1>Hi, #{name}</h1></body></html>\r\n"
  else
    response = "HTTP/1.1 404 Not Found\r\n"
    response += "Content-Type: text/html\r\n"
    response += "\r\n"
    response += "<html><body><h1>404 Not Found</h1></body></html>\r\n"
  end

  client.puts response
  client.close
end


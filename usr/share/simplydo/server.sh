#!/bin/bash

# Function to handle the request and generate the response
handle_request() {
  local path="$1"
  local query="$2"

  if [[ "$path" == "login" ]]; then
    local password=$(sed -n 's/^password=//p' <<< "$query" | sed 's/%22//g')
    local stored_password=$(grep -Po '(?<=password: ")[^"]*' config.yml)

    if [[ "$password" == "$stored_password" ]]; then
      echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Success</h1></body></html>"
    else
      echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Invalid</h1></body></html>"
    fi
  elif [[ "$path" == "sayhello" ]]; then
    local name=$(sed -n 's/^name=//p' <<< "$query" | sed 's/%22//g')
    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Hi, $name</h1></body></html>"
  else
    echo -e "HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n<html><body><h1>404 Not Found</h1></body></html>"
  fi
}

# Start the server
main() {
  local server_port=2003

  # Create a TCP server
  exec 3<>/dev/tcp/0.0.0.0/$server_port

  # Main server loop
  while true; do
    # Accept client connection
    local client=""
    read -r -u 3 client || break

    # Read client request
    local request=""
    while IFS= read -r -u "$client" line; do
      request+="$line"$'\n'
      if [[ -z "$line" ]]; then
        break
      fi
    done

    # Extract the request path and query parameters
    local path=$(awk -v req="$request" 'BEGIN { print req }' RS=' ' | awk -F'/' '{ print $2 }')
    local query=$(awk -v req="$request" 'BEGIN { print req }' RS=' ' | awk -F'\\?' '{ print $2 }')

    # Handle the request and generate the response
    local response=$(handle_request "$path" "$query")

    # Send the response to the client
    echo -e "$response" >&"$client"

    # Close the client connection
    exec "$client">&-
  done

  # Close the server connection
  exec 3>&-
}

main


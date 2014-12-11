#!/usr/bin/env ruby
require "net/http"
require "uri"


uri = URI.parse("http://online-logger.cf.covisintrnd.com")
host = uri.host
port = uri.port
http = Net::HTTP.new(host,port)
message="Rumtime Directory: #{Dir.pwd}"
path = "/log?m=#{URI::encode(message)}"
response = http.send_request("PUT",path)

dirs = Dir["#{Dir.pwd}/app/*"]
message = "Directories within app: #{dirs}"
path = "/log?m=#{URI::encode(message)}"
response = http.send_request("PUT",path)


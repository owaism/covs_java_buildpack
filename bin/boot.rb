#!/usr/bin/env ruby
require "net/http"
require "uri"


uri = URI.parse("http://online-logger.cf.covisintrnd.com")
host = uri.host
port = uri.port
http = Net::HTTP.new(host,port)
dirs = Dir[Dir.pwd]
message="From BOOT RB: #{dirs}"
path = "/log?m=#{URI::encode(message)}"
response = http.send_request("PUT",path)


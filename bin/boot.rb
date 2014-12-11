#!/usr/bin/env ruby

ROOT_PATH = File.expand_path(".")
$LOAD_PATH << ROOT_PATH
require "net/http"
require "uri"
require "online_logger"


uri = URI.parse("http://online-logger.cf.covisintrnd.com")
host = uri.host
port = uri.port
http = Net::HTTP.new(host,port)
message="Runtime Directory: #{Dir.pwd}"
path = "/log?m=#{URI::encode(message)}"
response = http.send_request("PUT",path)

dirs = Dir["/home/vcap/app/*"]
message = "Directories within app: #{dirs}"
path = "/log?m=#{URI::encode(message)}"
response = http.send_request("PUT",path)



OnlineLogger.instance.debug("Boot Online Logger")
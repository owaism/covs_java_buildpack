#!/usr/bin/env ruby

ROOT_PATH = File.expand_path(".")
$LOAD_PATH << ROOT_PATH
require "net/http"
require "uri"
require "online_logger"

logger = OnlineLogger.instance

logger.info("Started booting the system")

logger.info("Starting Apache...")

response = `/home/vcap/app/apache2/bin/apachectl -f /home/vcap/app/apache2/conf/httpd.conf`

logger.info("Response of apache2 start: #{response}")
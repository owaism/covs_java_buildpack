require "net/http"
require "singleton"
require "uri"


class OnlineLogger

    include ::Singleton

    def initialize
      uri = URI.parse("http://online-logger.cf.covisintrnd.com")
      @host = uri.host
      @port = uri.port
      @http = Net::HTTP.new(@host,@port)
    end

    def debug(message)
      log("DEBUG",message);
    end

    def error(message)
      log("ERROR", message)
    end

    def info(message)
      log("INFO", message)
    end


    def reset()
      response = @http.send_request("DELETE","/log")

      fail "logger failed to reset" unless(response.code.to_i <300 && response.code.to_i >=200)
    end

    private
    def log(level, message)
      time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
      message = "#{level} - #{time}: #{message}"
      path = "/log?m=#{URI::encode(message)}"

      response = @http.send_request("PUT",path)

      fail "logger failed to log message" unless(response.code.to_i <300 && response.code.to_i >=200)

    end

end
#!/usr/bin/env ruby

require "java_buildpack/common/logger_factory"
require "java_buildpack/common/application"

module JavaBuildpack
  class Buildpack
    
    include JavaBuildpack
    
    def initialize
      @logger = Common::LoggerFactory.instance.get_logger Buildpack
    end
    
    def detect build_dir
      @logger.debug("detecting if archive present in #{build_dir} can be handled by this buildpack.")
      
      exit_status = (File.exists? File.join build_dir,"web.xml")? 0:1
      
      @logger.debug("Not Detected for this buildpack") unless exit_status == 0
      puts "nothing"
      exit 1
      
    end
    
    def compile build_dir, cache_dir
      puts "$HOME"
      @logger.debug("Request to compile...")
    end
    
    def release build_dir
      @logger.debug(build_dir)
    end
  end
end
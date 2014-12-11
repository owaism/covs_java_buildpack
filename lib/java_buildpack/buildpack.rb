#!/usr/bin/env ruby

require "java_buildpack/common/logger_factory"
require "java_buildpack/common/application"
require "java_buildpack/components"
require "java_buildpack/online_logger"
require "fileutils"

module JavaBuildpack
  class Buildpack
    
    include JavaBuildpack
    include Common
    
    def initialize
      @logger = Common::LoggerFactory.instance.get_logger Buildpack
      @online_logger = OnlineLogger.instance;
    end
    
    def detect build_dir
      @logger.debug("detecting if archive present in #{build_dir} can be handled by this buildpack.")
      @online_logger.info("Starting detect phase")

      exit_status = (File.exists? File.join build_dir,"web.xml")? 0:1
      
      @logger.debug("Not Detected for this buildpack") unless exit_status == 0
      @online_logger.info("Ending Detect Phase")
      exit 1
      
    end
    
    def compile (build_dir, cache_dir, buildpack_dir)

      @online_logger.reset
      @online_logger.info("starting compile phase...")

      puts "Compile Phase Begins: "
      @application = Application.new(build_dir, cache_dir, buildpack_dir)
      Components.install(@application)
      FileUtils.cp(File.join(buildpack_dir,"bin/boot.rb"),build_dir)

      @online_logger.info("ending compile phase...")
    end
    
    def release build_dir
      @logger.debug(build_dir)
    end
  end
end
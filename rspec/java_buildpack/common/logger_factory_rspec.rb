#!/usr/bin/env ruby

ROOT_PATH = File.expand_path("../../../")
$LOAD_PATH << File.join(ROOT_PATH,"lib")

module TestBase
  
  require "java_buildpack/common/configuration"
  
  require "java_buildpack/common/logger_factory"
  
  logger = JavaBuildpack::Common::LoggerFactory.instance.get_logger TestBase
  logger.debug("test")
  
end
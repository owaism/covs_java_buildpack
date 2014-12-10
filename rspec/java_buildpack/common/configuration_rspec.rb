#!/usr/bin/env ruby


$LOAD_PATH << File.expand_path('../../../../lib', __FILE__)
module TestBase
  
  require "java_buildpack/common/configuration"
  
  JavaBuildpack::Common::Configuration.get "logging.yml"
end
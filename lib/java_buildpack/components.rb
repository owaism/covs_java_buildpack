#!/usr/bin/env ruby


require "java_buildpack/components/apache2"
require "java_buildpack/common"
require "java_buildpack/common/configuration"

module JavaBuildpack
  module Components
    
    include JavaBuildpack
    include Common
    
    def Components.install(application)
      configs = Configuration.get("components")
      puts "COMPONENT CONFIGURATION #{configs}"
      apache2 = Apache2.new(application, configs["components"]["apache2"]["tar_file_path"], application.build_dir)
      apache2.install
    end
  end
end
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
      apache2 = Apache2.new(configs["components"]["apache2"]["tar_file_path"], application.build_dir)
    end
  end
end
#!/usr/bin/env ruby


require "java_buildpack/components/apache2"
require "java_buildpack/common"
require "java_buildpack/common/configuration"

module JavaBuildpack
  module Components
    
    include JavaBuildpack
    include Common
    
    def Components.compile_all(application)
      Apache2.new(application).compile
    end
  end
end
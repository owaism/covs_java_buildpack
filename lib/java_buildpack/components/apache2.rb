#!/usr/bin/env ruby

require "java_buildpack/components/component"
module JavaBuildpack
  module Components
    
    class Apache2 < Component
      
      include JavaBuildpack
      include Components

      def initialize (application)
        super
        @component_name = "apache2"
      end
      
    end
    
    
  end
end
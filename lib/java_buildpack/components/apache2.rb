#!/usr/bin/env ruby

module JavaBuildpack
  module Components
    
    class Apache2
      
      include JavaBuildpack
      include Components
      
      
      def initialize(apache2_tar_file, build_dir)
        @apache2_tar_file = apache2_tar_file
        @build_dir = build_dir
        puts "Apache2 initialized."
      end
      
    end
    
    
  end
end
#!/usr/bin/env ruby

module JavaBuildpack
  module Components
    
    class Component
      
      include JavaBuildpack
      include Components
      
      public
      
      def initialize(application, tar_file, build_dir)
        
        @application = application
        @build_dir = build_dir
        @tar_file = File.join(application.buildpack_dir, tar_file)
        
        fail "Tar file #{@tar_file} does not exist." unless File.exists?(@tar_file)
      end
      
      def install
        untar
      end
      
      private
      
      def untar
        puts "Untarring #{@tar_file}..."
        result = %x(tar -xf #{@tar_file} -C #{@build_dir};echo "true")
        puts "#{@tar_file} untarred...#{result}"
        apache2Dir = File.join(@build_dir, "apache2")
        apache2DirFiles = Dir[apache2Dir+"/*"]
        puts "APACHE 2 DIRECTORY STRUCTURE: #{apache2DirFiles}"
      end
      
    end
    
    
  end
end
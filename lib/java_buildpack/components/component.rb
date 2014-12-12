#!/usr/bin/env ruby
require "java_buildpack/common"
require "java_buildpack/common/configuration"
require "java_buildpack/common/application"
require "online_logger"


module JavaBuildpack
  module Components
    
    class Component
      
      include JavaBuildpack
      include Components
      include Common
      
      public
      
      def initialize(application)
        @application = application
        @logger = OnlineLogger.instance
      end

      def download_tar
        @logger.info("Attempting #{@component_name} download...")
        cache_dir = @application.cache_dir
        cache_dir_component = File.join(cache_dir, @component_name)
        build_dir_component = File.join(@application.build_dir, @component_name)

        @logger.debug("Cache DIR Component: #{cache_dir_component}")
        @logger.debug("Build DIR Component: #{build_dir_component}")


        if File.exists?(cache_dir_component)
          @logger.info("Download files found from cache...")
          FileUtils.cp_r(cache_dir_component, @application.build_dir)

        else
          @logger.info("Starting #{@component_name} download...")
          @logger.info("#{@application.build_dir} exists: #{File.exist? @application.build_dir}")
          %x(cd #{@application.build_dir})
          download_file_name = "#{@component_name}.tar.gz"

          @logger.debug("`curl -l -o #{download_file_name} #{@configuration['download_url']}`")
          `curl -l -o #{download_file_name} #{@configuration["download_url"]}`

          @logger.debug("untarring...#{download_file_name}")
          `tar xf #{download_file_name}`

          directory_name = @configuration["downloaded_dir_name"]

          `mv #{directory_name} #{@component_name}`

          @logger.debug("renamed to...#{@component_name}")
          `rm #{download_file_name}`

          FileUtils.cp_r(build_dir_component, cache_dir_component)
        end
      end

      
      def compile
        download_tar
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


      protected

        def configurations
          @configuration = Configuration.get(@component_name)
          @configuration
        end
      
    end
    
    
  end
end
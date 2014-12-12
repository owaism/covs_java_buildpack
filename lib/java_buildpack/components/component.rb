#!/usr/bin/env ruby
require "java_buildpack/common"
require "java_buildpack/common/configuration"
require "java_buildpack/common/application"
require "online_logger"
require "net/http"


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

      def download_tar(source_loc, dest_loc)
        @logger.info("Attempting #{source_loc} download...")

        Dir.chdir(@application.build_dir)
        download_uri = URI.parse(source_loc)
        downloaded_filename = File.basename(download_uri.path)
        downloaded_file_loc = File.join(dest_loc,downloaded_filename)
        Net::HTTP.start(download_uri.host) { |http|
          download_file = open(downloaded_file_loc)
          http.request_get(download_uri.path) { |resp|
            resp.read_body { |segment|
              download_file.write(segment)
            }
          }
          download_file.close
        }
        downloaded_file_loc
        end
      end


      def compile
        tar_file = download_tar(@configuration["download_url"], @application.build_dir)
        untar(tar_file)
        `rm #{tar_file}`
        @logger.debug("Removed Tar File.")
      end

    private

      def untar(tar_file)
        untarred_dir_name = File.join(File.dirname(tar_file),File.basename(tar_file,".*"))
        @logger.debug("untarring...#{tar_file}")
        `tar xf #{tar_file}`
        @logger.debug("Untarred to #{untarred_dir_name}: #{File.exists? untarred_dir_name}")
        untarred_dir_name
      end


      protected

      def configurations
        @configuration = Configuration.get(@component_name)
        @configuration
      end

    end


end
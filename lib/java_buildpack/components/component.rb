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
        @download_file_counter=0
      end


      def compile
        @logger.debug("Compile Component: #{@component_name}. Configus: #{configurations()}")
        tar_file = download_tar(@configuration["download_url"], @application.build_dir)
        untar(tar_file)
        `rm #{tar_file}`
        @logger.debug("Removed Tar File.")
      end


      protected

      def configurations
        @configuration = Configuration.get(@component_name)
        @configuration
      end

      def untar(tar_file)
        @logger.debug("untarring...#{tar_file}")
        @logger.debug(tar_file.index("."))
        # removing all extensions
        untarred_dir_name = (tar_file.index(".") > 0)? tar_file[0, tar_file.index(".")]: tar_file
        `tar xf #{tar_file}`
        @logger.debug("Untarred to #{untarred_dir_name}: #{File.exists? untarred_dir_name}")
        untarred_dir_name
      end

      def download_tar(source_loc, dest_loc)
        @logger.info("Attempting #{source_loc} download...")

        download_uri = URI.parse(source_loc)
        downloaded_filename = File.basename(download_uri.path)
        downloaded_file_loc = File.join(dest_loc, downloaded_filename)

        @logger.debug("Downloading #{source_loc} to #{downloaded_file_loc}")
        @logger.debug("inspect download_uri")

        `curl -o #{downloaded_file_loc} #{source_loc}`


        # Net::HTTP.start(download_uri.host) { |http|
        #   download_file = open(downloaded_file_loc)
        #   http.request_get(download_uri.path) { |resp|
        #     resp.read_body { |segment|
        #       download_file.write(segment)
        #     }
        #   }
        #   download_file.close
        # }

        @logger.info("#{downloaded_file_loc} Download successful: #{File.exists? downloaded_file_loc}")
        new_file_location = File.join(dest_loc, "#{@component_name}-#{@download_file_counter}")
        FileUtils.move(downloaded_file_loc, new_file_location)
        @download_file_counter+=1

        @logger.info("Moved #{downloaded_file_loc} to #{new_file_location}")
        new_file_location
      end

    end

  end


end
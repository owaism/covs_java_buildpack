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

      end


      protected

      def configurations
        @configuration = Configuration.get(@component_name)
        @configuration
      end

      def untar(tar_file)
        @logger.debug("untarring...#{tar_file}")

        basefilename = File.basename(tar_file,".*") if (tar_file.end_with? "tar.gz")


        # removing all extensions
        untarred_dir_name = File.join(File.dirname(tar_file),File.basename(basefilename,".*"))
        `tar xf #{tar_file}`
        @logger.debug("Untarred to #{untarred_dir_name}: #{File.exists? untarred_dir_name}")

        new_untarred_dir = File.join(File.dirname(tar_file), "#{@component_name}-#{@download_file_counter}.tar")
        FileUtils.move(untarred_dir_name, new_untarred_dir)
        @download_file_counter+=1

        @logger.info("Moved #{untarred_dir_name} to #{new_untarred_dir}")
        new_untarred_dir

      end

      def download_tar(source_loc, dest_loc)
        @logger.info("Attempting #{source_loc} download...")

        download_uri = URI.parse(source_loc)
        downloaded_filename = File.basename(download_uri.path)
        downloaded_file_loc = File.join(dest_loc, downloaded_filename)

        @logger.debug("Downloading #{source_loc} to #{downloaded_file_loc}")
        @logger.debug("inspect download_uri")

        `curl -o #{downloaded_file_loc} #{source_loc}`


        @logger.info("#{downloaded_file_loc} Download successful: #{File.exists? downloaded_file_loc}")
        downloaded_file_loc
      end

    end

  end


end
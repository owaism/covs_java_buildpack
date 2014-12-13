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

      # The main compile phase of this component.
      # in this phase apache source is downloaded along with all other dependencies (zlib)/
      # Apache is then configured and compiled from source
      def compile
        # setup configurations
        configurations

        # Download and untar apache2
        apache2 = download_untar @configuration["download_url"]

        # download and untar zlib
        zlib = download_untar @configuration["zlib_download_url"]

        # configure and compile zlib
        zlib_configure_file = File.join(zlib,"configure")
        zlib_install_dir = File.join(@application.cache_dir,"zlib")
        result = `#{zlib_configure_file} --prefix=#{zlib_install_dir}`

        @logger.debug("Configure ZLIB result: #{result[0..50]}")

        # Make zlib
        result = `make -C #{zlib}`
        @logger.debug("Make ZLIB result: #{result[0..50]}")
        result = `make install -C #{zlib}`
        @logger.debug("Make Install Result: #{result[0..50]}")


        end

        def download_untar (download_url)
          @logger.debug("Compile Component: #{@component_name}. Configs: #{@configuration}")
          tar_file = download_tar(download_url, @application.build_dir)
          untar_dir = untar(tar_file)
          `rm #{tar_file}`
          @logger.debug("Removed Tar File.")
          untar_dir
        end

      end


    end
  end
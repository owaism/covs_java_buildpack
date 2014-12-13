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

        @logger.debug"ZlIB Dir Content: #{Dir[File.join(zlib,"*")]}"
        # configure and compile zlib
        zlib_configure_file = File.join(zlib,"configure")
        zlib_install_dir = File.join(@application.cache_dir,"zlib")

        shell_script = File.join(@application.buildpack_dir,"resources/shell/compile_zlib.sh");
         fail "Shell Script failed" unless 0 == system("set +x;./#{shell_script}")
        # @logger.debug("#{zlib_configure_file} --prefix=#{zlib_install_dir}")
        # result = system("#{zlib_configure_file} --prefix=#{zlib_install_dir}")
        #
        # puts result
        # @logger.debug("Configure ZLIB result: #{result[0..-100]}")
        #
        # # Make zlib
        # @logger.debug("make -C #{zlib}")
        # result = `make -C #{zlib}`
        # puts result
        # @logger.debug("Make ZLIB result: #{result[0..-100]}")
        # @logger.debug("make install -C #{zlib}")
        # result = `make install -C #{zlib}`
        # @logger.debug("Make Install Result: #{result[0..-100]}")

        @logger.debug "Zlib Install Location: #{Dir[File.join(zlib_install_dir,'*')]}"

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
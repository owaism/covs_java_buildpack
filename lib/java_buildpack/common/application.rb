#!/usr/bin/env ruby


require "yaml"
require "java_buildpack/common/configuration"

module JavaBuildpack
  module Common
    class Application

      attr_reader :buildpack_dir
      attr_reader :cache_dir
      attr_reader :build_dir
      attr_reader :config
      #attr_reader :details
      #attr_reader :services
      attr_reader :environment
      
      # Construct Application Object
      def initialize(build_dir, cache_dir, buildpack_dir)
        
        @config = Configuration.get("application")        
        @build_dir = build_dir
        @cache_dir = cache_dir
        @buildpack_dir = buildpack_dir
        
        raise "Covisint Java Buildpack not downloaded propertly" unless File.exists?(@buildpack_dir)

        @environment = ENV.to_hash
        #@details     = parse(@environment.delete('VCAP_APPLICATION'))
        #@services    = Services.new(parse(@environment.delete('VCAP_SERVICES')))

      end
    end

  end
end
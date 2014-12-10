#!/usr/bin/env ruby


require "yaml"
require "java_buildpack/common/configuration"

module JavaBuildpack
  module Common
    class Application

      attr_reader :buildpack_dir
      #attr_reader :details
      #attr_reader :services
      attr_reader :environment
      
      # Construct Application Object
      def initialize(buildpath)
        
        @config = Configuration.get("applicaiton")        
        
        @buildpack_dir = File.join build_dir, config["application"]["buildpack_dir"];
        raise "Covisint Java Buildpack not downloaded propertly" unless Files.exists?(@buildpack_dir)

        @environment = ENV.to_hash
        #@details     = parse(@environment.delete('VCAP_APPLICATION'))
        #@services    = Services.new(parse(@environment.delete('VCAP_SERVICES')))

      end
    end

  end
end
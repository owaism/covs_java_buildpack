#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

module JavaBuildpack
  module Common
    module Configuration

      CONF_DIR = File.join ROOT_PATH,"conf"
      fail "Configuration Directory not present!!!" unless File.exists? CONF_DIR
      
      def Configuration.get(filename)
        conf_file = File.join CONF_DIR, "#{filename}.yml";
        fail "Configuration file #{filename} not found in configuration directory: #{CONF_DIR}" unless File.exists? conf_file        
        YAML.load_file(conf_file)
      end
    end
  end
end
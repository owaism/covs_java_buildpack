#!/usr/bin/env ruby

require 'logger'
require 'monitor'
require 'singleton'
require 'fileutils'
require "java_buildpack"
require "java_buildpack/common"
require "java_buildpack/common/configuration"

module JavaBuildpack
  module Common
    class LoggerFactory

      include ::Singleton
      attr_reader :initialized
      def initialize
        @configuration = Configuration.get "logging"
        @log_dir = @configuration["logger"]["dir"]
        @log_file = @configuration["logger"]["filename"]
        @default_level = @configuration["logger"]["leveld"]
        
              
        absolute_log_dir = File.expand_path(@log_dir)
        absolute_log_file = File.join(absolute_log_dir, @log_file)
        
        puts "LOG FILE #{absolute_log_file}"

        FileUtils.mkdir_p absolute_log_dir unless File.exists? absolute_log_dir
        File.new(absolute_log_file, File::CREAT|File::TRUNC|File::RDWR) unless File.exists? absolute_log_file

        BuildpackLogger.setup(absolute_log_file)
      end

      def get_logger (klazz)
        BuildpackLogger.new klazz
      end

    end

    class BuildpackLogger < ::Logger

      def BuildpackLogger.setup (logfile)
       @@file_logger =BuildpackLogger.initLogger(logfile)
       
       @@console_logger = nil
       if(ENV.to_hash["LOG2CONSOLE"] != nil)
         @@console_logger = BuildpackLogger.initLogger(STDERR);
       end
      end
      
      def BuildpackLogger.initLogger(logOutput)
        
        logger = Logger.new(logOutput);
        logger.level= ::Logger::DEBUG
  
        logger.formatter = lambda do |severity, datetime, klass, message|
          "#{datetime.strftime('%FT%T.%2N%z')} #{klass.to_s.ljust(10)} #{severity.ljust(5)} #{message}\n"
        end
        
        logger
      end

      # Creates an instance
      #
      def initialize(klass)
        @klass     = klass
        @delegates = [@@file_logger]
        
        if(nil != @@console_logger)
          @delegates << @@console_logger
        end
      end

      # Adds a message to the delegate +Logger+ instances
      #
      # @param [Logger::Severity] severity the severity of the message
      # @param [String] message the message
      # @param [String] progname the message when passed in as a parameter
      # @yield evaluated for the message
      # @return [Void]
      def add(severity, message = nil, progname = nil, &block)
        @delegates.each { |delegate| delegate.add severity, message || progname, @klass, &block }
      end

    end

  end
end
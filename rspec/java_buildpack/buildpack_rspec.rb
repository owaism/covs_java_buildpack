#!/usr/bin/env ruby

ROOT_PATH = File.expand_path("../../")
$LOAD_PATH << File.join(ROOT_PATH, "lib")

module TestBase
  
  puts $LOAD_PATH  
  require "java_buildpack/buildpack"
  class BuildpackTest
    
  end
end

puts JavaBuildpack::Buildpack.new
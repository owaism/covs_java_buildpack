#!/usr/bin/env ruby

ROOT_PATH = File.expand_path("../buildpacks/covs_java_buildpack")
$LOAD_PATH << File.join(ROOT_PATH, "lib")

require 'java_buildpack/buildpack'
include JavaBuildpack

JavaBuildpack::Buildpack.new.compile ARGV[0], ARGV[1]
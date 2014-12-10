#!/usr/bin/env ruby

build_dir = ARGV[0]
cache_dir = ARGV[1]
buildpack_dir = ARGV[2]

ROOT_PATH = File.expand_path(buildpack_dir)
$LOAD_PATH << File.join(ROOT_PATH, "lib")

require 'java_buildpack/buildpack'
include JavaBuildpack

JavaBuildpack::Buildpack.new.compile build_dir, cache_dir, buildpack_dir
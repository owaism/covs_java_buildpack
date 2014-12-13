#!/usr/bin/env bash

set -e            # fail fast
set -o pipefail   # don't ignore exit codes when piping output
set -x          # enable debugging
cd /tmp/staged/app/apache2-1
./configure --prefix=/tmp/cache/zlib
make
make install
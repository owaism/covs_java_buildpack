#!/bin/sh

cd /tmp/staged/app/apache2-1
./configure --prefix=/tmp/cache/zlib
make
make install
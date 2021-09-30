#!/bin/bash
srcdir=$SRC_DIR
mkdir build
cd build
cmake ..
make lib
make install

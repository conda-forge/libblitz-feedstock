#!/bin/bash
set -ex

if [[ $ARCH == 64 ]];
then
	export ARCH_CMD="--enable-64bit"
else
	export ARCH_CMD="--enable-simd-width=8"
fi

autoreconf -vif

./configure \
  --prefix="${PREFIX}" \
  --enable-static \
  --enable-shared \
  --enable-optimize \
  --enable-threadsafe \
  --enable-serialization \
  ${ARCH_CMD} \
  CPPFLAGS="-I${PREFIX}/include -pthread" \
  CFLAGS="-I${PREFIX}/include -pthread -DBZHAVE_STD" \
  CXXFLAGS="-I${PREFIX}/include -pthread -DBZHAVE_STD" \
  LDFLAGS="-L${PREFIX}/lib"

make lib
make install

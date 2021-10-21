#!/bin/bash
# Get an updated config.sub and config.guess
rm -rf ./config
mkdir ./config
cp $BUILD_PREFIX/share/gnuconfig/config.* ./config
set -ex

libtoolize
aclocal
autoheader
automake --add-missing
autoreconf

if [[ $ARCH == 64 ]];
then
	export ARCH_CMD="--enable-64bit"
else
	export ARCH_CMD="--enable-simd-width=8"
fi

# --enable-optimize breaks Tensorflow, see https://github.com/conda-forge/ctng-compiler-activation-feedstock/issues/57#issuecomment-941439534
./configure \
  --prefix="${PREFIX}" \
  --enable-static \
  --enable-shared \
  --enable-threadsafe \
  --enable-serialization \
  ${ARCH_CMD} \
  CPPFLAGS="${CPPFLAGS} -pthread" \
  CFLAGS="${CFLAGS} -pthread -DBZHAVE_STD" \
  CXXFLAGS="${CXXFLAGS} -pthread -DBZHAVE_STD" \
  LDFLAGS="${LDFLAGS}"

make lib
make install

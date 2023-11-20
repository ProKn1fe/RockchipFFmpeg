#!/bin/bash

#MPP
git clone https://github.com/rockchip-linux/mpp.git -b develop
cd mpp
cmake CMakeLists.txt
make -j$(nproc)
make install
cd ..

#linux-rga-multi
git clone https://github.com/tsukumijima/librga-rockchip.git
cd librga-rockchip
debuild -us -uc -b && cp -a ../*.deb ./
dpkg -i librga*.deb
cd ..

#FFMpeg
git clone https://github.com/hbiyik/FFmpeg.git
cd FFmpeg

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
	--prefix="$HOME/ffmpeg_build" \
	--pkg-config-flags="--static" \
	--extra-cflags="-I$HOME/ffmpeg_build/include" \
	--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
	--extra-libs="-lpthread -lm" \
	--ld="g++" \
	--bindir="$HOME/bin" \
	--enable-gpl \
	--enable-gnutls \
	--enable-libaom \
	--enable-libass \
	--enable-libfdk-aac \
	--enable-libfreetype \
	--enable-libmp3lame \
	--enable-libopus \
	--enable-libdav1d \
	--enable-libvorbis \
	--enable-libvpx \
	--enable-libx264 \
	--enable-libx265 \
	--enable-nonfree \
	--enable-rkmpp \
	--enable-version3 \
	--enable-libdrm && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install

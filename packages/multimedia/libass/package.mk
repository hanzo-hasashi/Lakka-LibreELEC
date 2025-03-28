# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libass"
PKG_VERSION="0.17.0"
PKG_SHA256="971e2e1db59d440f88516dcd1187108419a370e64863f70687da599fdf66cc1a"
if [ "${DISTRO}" = "Lakka" ]; then
  PKG_VERSION="0.14.0"
  PKG_SHA256="881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2"
fi
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/libass/libass"
PKG_URL="https://github.com/libass/libass/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain freetype fontconfig fribidi harfbuzz"
PKG_LONGDESC="A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format."

PKG_CONFIGURE_OPTS_TARGET="--disable-test \
                           --enable-fontconfig \
                           --disable-libunibreak \
                           --disable-silent-rules \
                           --with-gnu-ld"

if [ "${DISTRO}" = "Lakka" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-harfbuzz"
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET//harfbuzz/}"
fi

if [ ${TARGET_ARCH} = "x86_64" -o "${TARGET_ARCH}" = "i386" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-asm"
fi

post_configure_target() {
  libtool_remove_rpath libtool
}

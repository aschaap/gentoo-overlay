# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#Ebuild based on Efficient-Compression-Tool

EAPI=8

DESCRIPTION="A compression program for further compressing JPEG image files."
HOMEPAGE="http://packjpg.encode.su/"
SRC_URI="https://github.com/packjpg/${PN}/archive//${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
MULTILIB_COMPAT=(abi_x86_{32,64} )
IUSE="upstream-cflags-only static"

S=${WORKDIR}/${P}/source

src_prepare() {
	default

	# update URLs in the help text and the readme
	# https://encode.su/threads/3148-ENCODE-RU-has-been-moved-to-ENCODE-SU
	sed -i 's/encode\.ru/encode\.su/g' packjpg.cpp ../Readme.txt

	# update Makefile to use make.conf's CPPFLAGS
	# removing -fomit-frame-pointer; included with most -O levels
	# removing -O3, -funroll-loops, -fomit-frame-pointer because they're typically in make.conf
	# leaving -ffast-math and -fsched-spec-load and since they're fairly specific, and -Wall and -pedantic for debugging errors
	if ! use upstream-cflags-only; then
		sed -i 's/CPPFLAGS = -I. -O3 -Wall -pedantic -funroll-loops -ffast-math -fsched-spec-load -fomit-frame-pointer -std=c++14/CXXFLAGS+= -I. -Wall -pedantic -ffast-math -fsched-spec-load/' Makefile
	fi

	sed -i 's/CPPFLAGS/CXXFLAGS/g' Makefile

	if ! use static; then
		sed -i '/^LDFLAGS  = /s/-static -static-libgcc -static-libstdc++//' Makefile
	fi

	# do not strip binaries
	sed -i 's/-s $(LDFLAGS)/$(LDFLAGS)/' Makefile
}

src_install() {
	dobin ${PN}

	dodoc ../Readme.txt
}

# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#Ebuild based on synfig

EAPI=8

inherit cmake

DESCRIPTION="Fast and effective C++ file optimizer"
HOMEPAGE="https://github.com/fhanau/Efficient-Compression-Tool"

#if [[ ${PV} == *9999* ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/fhanau/${PN}.git"
#else
# This does not work due to git submodules not being included in the archive
#	SRC_URI="https://github.com/fhanau/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+threads -ectmp3"

BDEPEND="dev-lang/nasm"
#DEPEND=""

# libleanify (unavailable)
# libzlib (Cloudflare's variant?)
# lodepng (in guru overlay)
# liboptipng (unavailable)
#RDEPEND="${DEPEND}
#	dev-libs/miniz
#	app-arch/zopfli
#	media-libs/lodepng
#	"

S=${WORKDIR}/${P}/src

#CMAKE_IN_SOURCE_BUILD=ON
#CMAKE_REMOVE_MODULES_LIST=""
#CMAKE_MAKEFILE_GENERATOR="emake"

#src_unpack() {
#   git-r3_fetch ${EGIT_REPO_URI} ${REFS} ${TAG}
#   git-r3_checkout ${EGIT_REPO_URI} ${WORKDIR}/${P} ${TAG}
#}

#src_prepare() {
#	eapply_user
#	cmake_src_prepare
#}

# CMAKE_POSITION_INDEPENDENT_CODE needs to be on for Gentoo
# BUILD_SHARED_LIBS must be OFF or it won't run due to missing obscure shared libraries
src_configure() {
#	CMAKE_BUILD_TYPE=Release
	local mycmakeargs=(
		-DCMAKE_POSITION_INDEPENDENT_CODE=1
		-DBUILD_SHARED_LIBS=OFF
		-DECT_MULTITHREADING=$(usex threads)
		-DECT_MP3_SUPPORT=$(usex ectmp3)
	)
	cmake_src_configure
}

#src_compile() {
#	cmake_src_compile
#}

#src_install() {
#	cmake_src_install
#}

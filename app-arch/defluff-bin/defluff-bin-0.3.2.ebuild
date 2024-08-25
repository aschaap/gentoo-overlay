# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker multilib-build

DESCRIPTION="Copyright Joachim Henke - like DeflOpt, further reduces the size of GZIP, PNG, and ZIP files"
HOMEPAGE="https://encode.su/threads/1214-defluff-a-deflate-huffman-optimizer"
SRC_URI="
 amd64? ( https://encode.su/attachment.php?attachmentid=1523&d=1302168264 -> ${P}-linux-x86_64.zip )
 x86?   ( https://encode.su/attachment.php?attachmentid=1522&d=1302168244 -> ${P}-linux-i686.zip )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~x86 ~amd64 -*"
MULTILIB_COMPAT=( abi_x86_{32,64} )
IUSE=""

RDEPEND=""
DEPEND=${RDEPEND}

S="${WORKDIR}"

QA_PREBUILT="/opt/bin/defluff"

src_install() {
	exeinto /opt/bin

	doexe "defluff"
}

pkg_postinst() {
	elog "More or less abandonware. This binary is from 2011."
	elog ""
	elog "Source not publicly available to the best of my knowledge."
	elog ""
	elog "Note: no arguments accepted."
	elog ""
	elog "Usage: defluff < infile.gz > outfile.gz"
	elog ""
	elog "x86 only for i686 and above."
}

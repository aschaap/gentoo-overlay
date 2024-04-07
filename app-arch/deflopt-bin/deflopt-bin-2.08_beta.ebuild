# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker multilib-build

DESCRIPTION="Copyright Ben Jos Walbeehm - further reduces the size of GZIP (.gz/.tgz), PNG, and ZIP files"
HOMEPAGE="https://web.archive.org/web/20140209022101/http://www.walbeehm.com/download/"
SRC_URI="https://www.joachimkluge.de/png/optimipng-0.64.2.7z"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~x86 ~amd64 -*"
MULTILIB_COMPAT=( abi_x86_32 )
IUSE=""

RDEPEND=""
DEPEND=${RDEPEND}

S="${WORKDIR}/optimipng-0.64.2/pngtools/unix"

QA_PREBUILT="/opt/bin/deflopt"

src_install() {
	exeinto /opt/bin

	newexe "DeflOpt" "deflopt"
}

pkg_postinst() {
	elog "More or less abandonware. Author wants attribution."
	elog ""
	elog "Source not publicly available to the best of my knowledge."
	elog ""
	elog "Note: help message is printed when program is invoked without"
	elog "arguments; options such as -h and --help are not recognized."
}

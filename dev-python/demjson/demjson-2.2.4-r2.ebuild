# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} pypy3 )

inherit distutils-r1

DESCRIPTION="Encoder, decoder, and lint/validator for JSON compliant with RFC 4627"
HOMEPAGE="http://deron.meranda.us/python/demjson/ https://pypi.org/project/demjson/"
SRC_URI="http://deron.meranda.us/python/${PN}/dist/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

PATCHES=( "${FILESDIR}/${P}-PR34-py3.9-support.patch" )

python_test() {
	cd test
	if python_is_python3; then
		2to3 -w --no-diffs test_demjson.py
	fi
	"${PYTHON}" test_demjson.py
}

python_install_all() {
	distutils-r1_python_install_all
	# Docs are .txt files
	if use doc; then
		dodoc docs/*.txt
	fi
}

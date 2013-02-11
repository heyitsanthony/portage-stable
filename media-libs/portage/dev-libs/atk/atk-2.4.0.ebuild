# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-2.4.0.ebuild,v 1.14 2012/12/16 06:01:24 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="http://projects.gnome.org/accessibility/"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="+introspection nls"

RDEPEND=">=dev-libs/glib-2.31.2:2
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/gtk-doc-am
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	G2CONF="${G2CONF} $(use_enable introspection)"
	DOCS="AUTHORS ChangeLog NEWS README"

	gnome2_src_prepare

	if ! use test; then
		# don't waste time building tests (bug #226353)
		sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed failed"
	fi
}
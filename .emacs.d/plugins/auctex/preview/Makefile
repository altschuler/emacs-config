# Makefile for AUCTeX

# Maintainer: auctex-devel@gnu.org

# Copyright (C) 2001, 2002, 2003, 2004, 2005,
#   2006 Free Software Foundation, Inc.

# This file is part of AUCTeX.

# AUCTeX is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.

# AUCTeX is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with AUCTeX; see the file COPYING.  If not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.


PACKAGE=preview
PACKAGE_INFO=preview-latex
EMACS=/usr/bin/emacs
ELCC=$(EMACS) -batch -q -no-site-file -no-init-file
AUCTEX=-eval '(let ((dir (pop command-line-args-left))) \
  (if (not (string-equal dir "")) (push dir load-path)))' $(auctexdir) --eval '(push "." load-path)'
AUTOLOAD=--eval '(let ((generated-autoload-file (expand-file-name "$@"))) \
		(update-file-autoloads "preview.el")(save-buffers-kill-emacs t))'

LISP_SOURCES = prv-emacs.el preview.el
LISP_OBJS = $(LISP_SOURCES:.el=.elc)

ICON_SOURCES = \
 images/prverr16.xpm  images/prverr20.xpm       images/prverr24.xbm \
 images/prverr24.xpm  images/prvtex-cap-up.xpm  images/prvtex12.xbm \
 images/prvtex12.xpm  images/prvtex16.xbm       images/prvtex16.xpm \
 images/prvtex20.xpm  images/prvtex24.xbm       images/prvtex24.xpm \
 images/prvwrk12.xpm  images/prvwrk14.xpm       images/prvwrk16.xpm \
 images/prvwrk20.xpm  images/prvwrk24.xbm       images/prvwrk24.xpm

prefix = C:/Program\\\ Files\\\ \\\(x86\\\)/Emacs$(null)
exec_prefix = ${prefix}$(null)
libdir = ${exec_prefix}/lib$(null)
packagedatadir = /usr/share/emacs/site-lisp/auctex$(null)
datarootdir = ${prefix}/share$(null)
datadir = ${datarootdir}$(null)
previewstartfile = /usr/share/emacs/site-lisp/preview-latex.el
packagedir = no$(null)
packagelispdir = /usr/share/emacs/site-lisp/auctex$(null)
auctexdir = ..$(null)
DESTDIR=

INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
MKINSTALLDIRS = ../mkinstalldirs

all: texmf lisp install-hint

lisp: $(LISP_OBJS)
	test "x$(packagedir)" != xno || $(MAKE) preview-latex.el

texmf: latex/Makefile
	(cd latex ; $(MAKE) all)

latex/Makefile: latex/Makefile.in Makefile config.status
	./config.status

auto.el: auto.el.in Makefile config.status
	./config.status

configure: configure.ac ../aclocal.m4
	autoconf -I..

Makefile: Makefile.in config.status
	./config.status

config.status: configure
	./config.status --recheck

install-hint:
	@echo 'Congratulations!  Build is complete.'
	@echo 
	@echo 'Now, run "make install" as root, or whatever user has permissions'
	@echo 'to write to the install directory.'


.PHONY: install install-texmf install-el install-images install-startup \
	install-nosearch use-hint all lisp texmf

install: install-texmf install-el install-nosearch install-images \
         install-startup use-hint

use-hint:
	@echo "Installation completed."
	@echo
	@echo "Please read the PROBLEMS file if you use"
	@echo "a) AUCTeX with a version less than 11.0"
	@echo "b) GNU Emacs with a version less than 21.2"
	@echo "   OR XEmacs with a version less than 21.4.9"
	@echo "c) Ghostscript with a version less than 6.51"
	@echo "Please use M-x preview-report-bug if you experience any"
	@echo "problems not mentioned in there."

install-el: $(LISP_OBJS) auto.el
	-$(MKINSTALLDIRS) $(DESTDIR)$(packagelispdir)
	for x in $(LISP_SOURCES) ; do \
	  echo $(INSTALL_DATA) $$x $(DESTDIR)$(packagelispdir) ; \
	  $(INSTALL_DATA) $$x $(DESTDIR)$(packagelispdir) ; \
	  echo $(INSTALL_DATA) $${x}c $(DESTDIR)$(packagelispdir) ; \
	  $(INSTALL_DATA) $${x}c $(DESTDIR)$(packagelispdir) ; \
	done

install-nosearch:
	-$(MKINSTALLDIRS) $(DESTDIR)$(packagedatadir)
	: >$(DESTDIR)$(packagedatadir)/.nosearch

install-images: $(ICON_SOURCES)
	-$(MKINSTALLDIRS) $(DESTDIR)$(packagedatadir)/images
	for x in $(ICON_SOURCES); do \
	  echo $(INSTALL_DATA) $$x $(DESTDIR)$(packagedatadir)/images ; \
	  $(INSTALL_DATA) $$x $(DESTDIR)$(packagedatadir)/images ; \
	done

install-texmf:
	(cd latex ; $(MAKE) DESTDIR=$(DESTDIR) install)

install-startup:
	test $(packagedir) != no || $(MAKE) preview-latex.el
	test $(packagedir) != no || \
	  $(INSTALL_DATA) preview-latex.el $(DESTDIR)$(previewstartfile)

$(LISP_OBJS):	$(LISP_SOURCES)
	for x in $(LISP_SOURCES) ; do \
	  echo $(ELCC) $(AUCTEX) -f batch-byte-compile $$x ; \
	  $(ELCC) $(AUCTEX) -f batch-byte-compile $$x ; \
	done

preview-latex.el: preview.el auto.el
	rm -f preview-latex.el
	-$(EMACS) -batch -no-site-file -no-init-file $(AUTOLOAD) ; \
	test -r $@ || { \
	  echo ";; Auto-generated preview-latex.el" > $@ ; \
	  echo "" >> $@ ; \
	  $(EMACS) -batch -no-site-file -no-init-file $(AUTOLOAD) ; \
	}
	cat auto.el >> $@

.PHONY: clean distclean maintainer-clean tarball-ready

clean:
	rm -f latex.out testdocstrip.tex preview-latex.el
	rm -rf *.prv *.elc *~ *.aux *.dvi *.log 
	(cd latex ; $(MAKE) clean)

distclean: clean
	rm -f config.log config.cache config.status
	rm -f Makefile */Makefile auto.el

maintainer-clean: 
	$(MAKE) distclean
	rm -rf autom4te.cache

# Generated automatically from Makefile.in by configure.
# $Header: /home/amb/cxref/doc/RCS/Makefile.in 1.3 2001/03/18 10:29:26 amb Exp $
#
# C Cross Referencing & Documentation tool. Version 1.5c.
#
# Documentation Makefile.
#
# Written by Andrew M. Bishop
#
# This file Copyright 1995,96,99,2001 Andrew M. Bishop
# It may be distributed under the GNU Public License, version 2, or
# any higher version.  See section COPYING of the GNU Public license
# for conditions under which this file may be redistributed.
#

# autoconf things

objdir=/home/cs/cs_guest/dessgi/DESS2002-2003/v1.0/cxref
srcdir=.

# The LaTeX and dvips programs

LATEX=latex
DVIPS=dvips

########

SRC_SOURCE_FILES= \
cxref.c       \
cxref.h       \
datatype.h    \
comment.c     \
file.c        \
func.c        \
preproc.c     \
type.c        \
var.c         \
xref.c        \
warn-raw.c    \
latex.c       \
html.c        \
rtf.c         \
sgml.c        \
slist.c       \
memory.h      \
memory.c      \
parse-yy.h

OBJ_SOURCE_FILES= \
autoconfig.h  \
latex-style.c \
parse-yacc.h  \
parse-lex.c   \
parse-yacc.c 

########

all : sources docs
	@

########

sources :
#
# Create the cross reference files
#
	@cd $(srcdir) && for file in $(SRC_SOURCE_FILES) ; do \
	   echo Cross referencing $$file ; \
	   ( cd .. ; $(objdir)/cxref -xref -O$(objdir)/doc -Ncxref $$file -I$(objdir) ) ; \
	done
	@for file in $(OBJ_SOURCE_FILES) ; do \
	   echo Cross referencing $$file ; \
	   ( cd .. ; $(objdir)/cxref -xref -O$(objdir)/doc -Ncxref $$file -I. ) ; \
	done
#
# Create the source files using cxref
#
	@cd $(srcdir) && for file in $(SRC_SOURCE_FILES) ; do \
	   echo Documenting $$file ; \
	   ( cd .. ; $(objdir)/cxref -warn-xref -xref -O$(objdir)/doc -Ncxref -latex2e -html32-src -rtf -sgml $$file -I$(objdir) ) ; \
	done
	@for file in $(OBJ_SOURCE_FILES) ; do \
	   echo Documenting $$file ; \
	   ( cd .. ; $(objdir)/cxref -warn-xref -xref -O$(objdir)/doc -Ncxref -latex2e -html32-src -rtf -sgml $$file -I. ) ; \
	done
#
# Create the index using cxref
#
	@echo Indexing
	@( cd .. ; $(objdir)/cxref -index-all -O$(objdir)/doc -Ncxref -latex2e -html32 -rtf -sgml )

########

docs :
#
# Create the final output using latex
#
	[ "x$(LATEX)" = "x" ] || $(LATEX) cxref.tex > /dev/null 2>&1
#
# Create the cross references using latex
#
	[ "x$(LATEX)" = "x" ] || $(LATEX) cxref.tex

########

clean :
	-rm -f *~ \
	*.sty *.tex *.html *.rtf *.sgml \
	cxref.function cxref.include cxref.typedef cxref.variable \
	cxref.aux cxref.dvi cxref.log cxref.toc

####

distclean : clean
	-rm -f Makefile

########

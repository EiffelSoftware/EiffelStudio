#
# Main makefile for PCCTS 1.33
#
# Terence Parr
# Parr Research Corporation
# September 1995
#
# verbosity versus silence...
PSss=
#
# this can be set to /user/local/bin etc...
BINDIR=bin
# This part added by Thomas Herter, M"unchen, Germany. See also manpages
# target.
MANDIR=$(HOME)/man
MANEXT=1
MANFILES=pccts.1 dlg/dlg.1 antlr/antlr.1

#CC=cc

.SILENT:

pccts:
	echo
	echo "               Welcome to PCCTS 1.33 installation"
	echo "                  Released October 5, 1995"
	echo
	echo "                           Featuring"
	echo "         ANTLR  -- ANother Tool for Language Recognition"
	echo "         DLG    -- DFA-based Lexical Analyzer Generator"
	echo "         [soon, we will merge SORCERER distribution with PCCTS]"
	echo
	echo "         Please see samples for C++ mode in pccts/testcpp"
	echo "         C, C++, and Pascal grammars available in"
	echo "             ftp.parr-research.com in pub/pccts/contrib"
	echo "         Please see the pre-release of The Book in"
	echo "             ftp.parr-research.com in pub/pccts/Book"
	echo
	echo "         Old tutorials are again at the ftp site at"
	echo "             ftp.parr-research.com in pub/pccts/old_tutorials"
	echo
	echo "         [see manpages target of this makefile]"
	echo
	echo "         [Trouble reports to parrt@parr-research.com]"
	echo
#
	echo Making executables...
	(cd antlr; make -s)
	echo antlr executable now in $(BINDIR)
	(cd dlg; make -s)
	echo dlg executable now in $(BINDIR)
	(cd support/genmk; make -s; mv genmk ../../$(BINDIR))
	echo genmk executable now in $(BINDIR)
	echo
	echo "       PCCTS 1.33 installation complete (have a nice day)"

manpages:
	if [ ! -d $(MANDIR) ] ; then mkdir $(MANDIR) ; fi
	cp -p $(MANFILES) $(MANDIR)/man$(MANEXT)

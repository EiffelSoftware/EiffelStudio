case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting mcon/man/metaxref.$manext (with variable substitutions)"
$rm -f metaxref.$manext
$spitshell >metaxref.$manext <<!GROK!THIS!
.TH METAXREF $manext "Version $VERSION PL$PATCHLEVEL"
''' @(#) Manual page for metaxref
'''
''' $Id: mxref.SH 78389 2004-11-30 00:17:17Z manus $
'''
'''  Copyright (c) 1991-1993, Raphael Manfredi
'''  
'''  You may redistribute only under the terms of the Artistic Licence,
'''  as specified in the README file that comes with the distribution.
'''  You may reuse parts of this distribution only within the terms of
'''  that same Artistic Licence; a copy of which may be found at the root
'''  of the source tree for dist 3.0.
'''
''' $Log$
''' Revision 1.1  2004/11/30 00:17:18  manus
''' Initial revision
'''
''' Revision 3.0.1.4  1997/02/28  16:30:39  ram
''' patch61: new -L option to match metaconfig and metalint
'''
''' Revision 3.0.1.3  1994/10/29  16:34:26  ram
''' patch36: the leading .TH was referring to metaconfig
'''
''' Revision 3.0.1.2  1993/10/16  13:52:46  ram
''' patch12: added BUGS section
'''
''' Revision 3.0.1.1  1993/08/19  06:42:25  ram
''' patch1: leading config.sh searching was not aborting properly
'''
''' Revision 3.0  1993/08/18  12:10:15  ram
''' Baseline for dist 3.0 netwide release.
'''
'''
.SH NAME
metaxref \- builds cross-reference file/unit/item information
.SH SYNOPSIS
.B metaxref
[ \-\fBdhkmsV\fR ] [ \fB\-f\fI manifest\fR ]
[ \-\fBL \fIdir\fR ]
.SH DESCRIPTION
.I Metaxref
is a program that scans all the files in your MANIFEST file and produces
three files which contains information about how the files in that MANIFEST
reference items defined by metaconfig's unit files.
.PP
The first two files,
.I I.fui
and
.I I.uif
reference the \fIfile\fR, \fIunit\fR and \fIitems\fR sorted differently. The
third file, \fIObsolete\fR, dumps all the known obsolete symbols, in which
file they appear and the new symbol that should be used instead.
.PP
Note that obsolete symbols do not appear in the main cross-reference files,
but are only listed in the \fIObsolete\fR file. That's yet another incentive
to use the new symbols in your sources. :-)
.SH OPTIONS
.I Metaxref
recognizes the following options:
.TP 10
.B \-d
Turn on debug mode.
.TP
.B \-f\fI manifest\fR
Use an alternate \fImanifest\fR file.
.TP
.B \-h
Print help message and exit.
.TP
.B \-k
Keep temporary \fI.MT\fR directory.
.TP
.B \-m
Assume lots of memory and swap space. This will drastically improve the
symbol lookup time in your source files, at the expense of memory usage.
.TP
.B \-s
Turn on silent mode.
.TP
.B \-L\fI dir\fR
Override default library location (where the \fIU\fR units directory
can be found).
.TP
.B \-V
Print version number and exit.
.SH AUTHOR
Harlan Stenn <harlan@mumps.pfcs.com>
.SH FILES
.TP 10
.PD 0
LIB/dist/mcon/U/*.U
Public unit files.
.TP
U/*.U
Private unit files
.TP
I.fui
Lists information sorted by file, unit and item.
.TP
I.uif
Lists information sorted by unit, item and file.
.TP
Obsolete
Lists all the obsolete symbols used by the sources.
.PD
.sp
.in +5
where LIB is $privlibexp.
.in -5
.SH BUGS
Metaxref will list among the wanted items all those magic symbols defined
within units on the ?M: lines. Those are relevant only when metaconfig is
invoked with the \fB\-M\fR option.
.SH "SEE ALSO"
metaconfig($manext), metalint($manext)
!GROK!THIS!
chmod 444 metaxref.$manext

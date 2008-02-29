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
echo "Extracting pat/pat (with variable substitutions)"
cat >pat <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: pat.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# Original Author: Larry Wall <lwall@netlabs.com>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.5  1994/10/29  16:37:53  ram
# patch36: now unlinks all the files created by patlog in bugs
#
# Revision 3.0.1.4  1994/01/24  14:29:17  ram
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.3  1993/08/25  14:04:35  ram
# patch6: removal of patch temporary files did not work with gaps
#
# Revision 3.0.1.2  1993/08/24  12:14:39  ram
# patch3: now removes older patch temporary files within bugs
#
# Revision 3.0.1.1  1993/08/19  06:42:31  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:36  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>pat <<'!NO!SUBS!'

$progname = &profile;				# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("ahmnV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;

if (-f 'patchlevel.h') {
	open(PL,"patchlevel.h") || die "$progname: can't open patchlevel.h: $!\n";
	while (<PL>) {
		$bnum = $1 if /^#define\s+PATCHLEVEL\s+(\d+)/;
	}
	die "$progname: malformed patchlevel.h file.\n" if $bnum eq '';
	++$bnum;
} else {
	$bnum=1;
}

if ($opt_n) {
	&newer;				# Look for files newer than patchlevel.h
} elsif ($opt_a) {
	open(MANI,"MANIFEST.new") || die "No MANIFEST.new found.\n";
	@ARGV = ();
	while (<MANI>) {
		s|^\./||;
		next if m|^patchlevel.h|;		# This file is built by hand
		chop;
		($_) = split(' ');
		next if -d;
		push(@ARGV,$_);
	}
	close MANI;
} elsif ($opt_m) {
	open(MODS,"bugs/.mods$bnum") || die "$progname: no modification found.\n";
	@ARGV = ();
	while (<MODS>) {
		next if m|^patchlevel.h$|;		# This file is built by hand
		chop;
		($_) = split(' ');
		push(@ARGV,$_);
	}
	close MODS;
}

# Remove older patch temporary files

@patlist = &patseq($bnum - 1);
foreach $cpat (@patlist) {
	unlink <bugs/*.$cpat bugs/.logs$cpat bugs/.mods$cpat bugs/.xlog$cpat>;
	unlink <bugs/.pri$cpat bugs/.subj$cpat bugs/.clog$cpat bugs/.rlog$cpat>;
}

# Since we're about to launch other pat exectuables, disable ~/.dist_profile
# to protect them if they added some weird switches we don't need...

$ENV{'DIST'} = '/dev/null';		# Disable ~/.dist_profile

system 'perl', '-S', 'patcil', '-p', @ARGV;

# Update MANIFEST if necessary, then patcil it.

if (-f 'MANIFEST' && `diff MANIFEST.new MANIFEST 2>/dev/null` ne '') {
	system 'cp', 'MANIFEST.new', 'MANIFEST';
	system 'perl', '-S', 'patcil', '-p', 'MANIFEST';
	push(@ARGV, 'MANIFEST');
}

system 'perl', '-S', 'patdiff', @ARGV;
system 'perl', '-S', 'patmake';

sub usage {
	print STDERR "Usage: $progname [-ahmnV] [filelist]\n";
	print STDERR "  -a : all the files in MANIFEST.new\n";
	print STDERR "  -h : print this message and exit\n";
	print STDERR "  -m : all the modified files (which have been patciled)\n";
	print STDERR "  -n : all the files newer than patchlevel.h\n";
	print STDERR "  -V : print version number and exit\n";
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/newer.pl >>pat
$grep -v '^;#' ../pl/package.pl >>pat
$grep -v '^;#' ../pl/patseq.pl >>pat
$grep -v '^;#' ../pl/tilde.pl >>pat
$grep -v '^;#' ../pl/profile.pl >>pat
chmod +x pat
$eunicefix pat

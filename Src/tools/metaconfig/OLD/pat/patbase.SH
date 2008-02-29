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
echo "Extracting pat/patbase (with variable substitutions)"
cat >patbase <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patbase.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1994/01/24  14:29:24  ram
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/24  12:15:58  ram
# patch3: random cleanup
#
# Revision 3.0.1.1  1993/08/19  06:42:32  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:38  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patbase <<'!NO!SUBS!'

$progname = &profile;		# My name

require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("ahV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;

$RCSEXT = ',v' unless $RCSEXT;
$TOPDIR = '';			# We are at the top-level directory

if ($opt_a) {
	open(MANI,"MANIFEST.new") || die "No MANIFEST.new found.\n";
	@ARGV = ();
	while (<MANI>) {
		chop;
		s|^\./||;
		next if m|^patchlevel.h|;		# Special file
		($_) = split(' ');
		next if -d;
		push(@ARGV,$_);
	}
	close MANI;
}

foreach $file (@ARGV) {
	$files = &rcsargs($file);
	@files = split(' ',$files);
	$revs=0;
	$rlog = `rlog -r$baserev -r$revbranch $files 2>&1`;
	($revs) = ($rlog =~ /selected revisions: (\d+)/);
	if (!$revs) {
		print "$progname: $file has never been checked in--checking in...\n";
		system 'perl', '-S', 'patcil', $file;
	}
	elsif ($revs == 1) {
		print "Last revision for $file is $baserev.\n";
		system 'rcs', "-Nlastpat:$baserev", @files;
	}
	else {
		($lastrev) = ($rlog =~ /revision $revbranch\.(\d+)/);
		print "Last revision for $file is $revbranch.$lastrev.\n";
		system 'rcs', "-Nlastpat:$revbranch.$lastrev", @files;
	}
}

sub usage {
	print STDERR "Usage: $progname [-ahV] [filelist]\n";
	print STDERR "  -a : all the files in MANIFEST.new\n";
	print STDERR "  -h : print this message and exit\n";
	print STDERR "  -V : print version number and exit\n";
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patbase
$grep -v '^;#' ../pl/rcsargs.pl >>patbase
$grep -v '^;#' ../pl/comment.pl >>patbase
$grep -v '^;#' ../pl/tilde.pl >>patbase
$grep -v '^;#' ../pl/profile.pl >>patbase
chmod +x patbase
$eunicefix patbase

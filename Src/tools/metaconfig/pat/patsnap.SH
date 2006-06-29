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
echo "Extracting pat/patsnap (with variable substitutions)"
cat >patsnap <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patsnap.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.2  1994/01/24  14:33:08  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/24  12:22:08  ram
# patch3: created
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patsnap <<'!NO!SUBS!'

$progname = &profile;		# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("aho:V");

$SNAPSHOT = 'SNAPSHOT';		# Default snapshot file name

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;

$RCSEXT = ',v' unless $RCSEXT;
$TOPDIR = '';			# We are at the top-level directory
$SNAPSHOT = $opt_o if $opt_o;

if ($opt_a) {
	open(MANI,"MANIFEST.new") || die "$progname: can't read MANIFEST.new: $!\n";
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

open(SNAPSHOT, ">$SNAPSHOT") || die "$progname: can't create $SNAPSHOT: $!\n";

foreach $file (@ARGV) {
	$files = &rcsargs($file);
	@files = split(' ',$files);
	$revs=0;
	$rlog = `rlog -r$baserev -r$revbranch $files 2>&1`;
	($revs) = ($rlog =~ /selected revisions: (\d+)/);
	if (!$revs) {
		print "$progname: $file has never been checked in--skipping\n";
		next;
	}
	elsif ($revs == 1) {
		print "$progname: last revision for $file is $baserev.\n";
		print SNAPSHOT "$file\t$baserev\n";
	}
	else {
		($lastrev) = ($rlog =~ /revision $revbranch\.(\d+)/);
		print "$progname: last revision for $file is $revbranch.$lastrev.\n";
		print SNAPSHOT "$file\t$revbranch.$lastrev\n";
	}
}

close SNAPSHOT;

sub usage {
	print STDERR <<EOM;
Usage: $progname [-ahV] [-o snapshot] [filelist]
  -a : all the files in MANIFEST.new
  -h : print this message and exit
  -o : specify snapshot file output (default $SNAPSHOT)
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patsnap
$grep -v '^;#' ../pl/rcsargs.pl >>patsnap
$grep -v '^;#' ../pl/comment.pl >>patsnap
$grep -v '^;#' ../pl/tilde.pl >>patsnap
$grep -v '^;#' ../pl/profile.pl >>patsnap
chmod +x patsnap
$eunicefix patsnap

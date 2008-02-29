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
echo "Extracting pat/patftp (with variable substitutions)"
cat >patftp <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patftp.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1994/01/24  14:30:43  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/24  12:16:57  ram
# patch3: removed useless orgname variable
#
# Revision 3.0.1.1  1993/08/19  06:42:36  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:44  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patftp <<'!NO!SUBS!'

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("hV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$RCSEXT = ',v' unless $RCSEXT;
chdir '..' if -d '../bugs';

&readpackage;

if ($#ARGV < 0) {
	open(PL,"patchlevel.h") || die "$progname: can't open patchlevel.h: $!\n";
	while (<PL>) {
		$argv = $1 if /^#define\s+PATCHLEVEL\s+(\d+)/;
	}
	close PL;
	die "$progname: malformed patchlevel.h file.\n" if $argv eq '';
	@ARGV = $argv;
} else {
	for (@ARGV) {
		s/^patch//;
	}
	$argv = &rangeargs(@ARGV);
	@ARGV = split(' ',$argv);
}

if ($#ARGV < 0) {
	print STDERR  "$progname: no patches specified.\n";
	&usage;
} elsif ($#ARGV) {
	print "$progname: copying $package $baserev patches $argv to $ftpdir...\n";
} else {
	print "$progname: copying $package $baserev patch $argv to $ftpdir...\n";
}

chdir 'bugs' || die "$progname: can't cd to bugs: $!\n";

until ($#ARGV < 0) {
	$patnum = shift;
	`cp patch$patnum $ftpdir`;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hV] patchlist
  -h : print this message and exit
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patftp
$grep -v '^;#' ../pl/rangeargs.pl >>patftp
$grep -v '^;#' ../pl/tilde.pl >>patftp
$grep -v '^;#' ../pl/profile.pl >>patftp
chmod +x patftp
$eunicefix patftp

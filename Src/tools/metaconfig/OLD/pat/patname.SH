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
echo "Extracting pat/patname (with variable substitutions)"
cat >patname <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patname.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.2  1994/01/24  14:31:02  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/19  06:42:40  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:46  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patname <<'!NO!SUBS!'

$progname = &profile;			# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage() unless &Getopts("ahnmv:V");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$RCSEXT = ',v' unless $RCSEXT;
$ENV{'DIST'} = '/dev/null';	# Disable ~/.dist_profile

chop($pwd = `pwd`) unless -f '.package';
until (-f '.package') {
	die "$progname: no .package file!  Run packinit.\n" unless $pwd;
	chdir '..' || die "$progname: can't cd ..: $!\n";
	$pwd =~ s|(.*)/(.*)|$1|;
	$prefix = $2 . '/' . $prefix;
}
if ($prefix) {
	for (@ARGV) {
		s/^/$prefix/ unless m|^[-/]|;
	}
}

# We now are at the top level

&readpackage;

unless ($opt_v) {
	print STDERR "$progname: version number must be specified using -v.\n";
	&usage;
}

if ($opt_n) {
	&newer;				# Look for files newer than patchlevel.h
} elsif ($opt_a) {
	open(MANI,"MANIFEST.new") || die "$progname: can't read MANIFEST.new: $!\n";
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

# Now loop over each file specified, doing a 'rcsfreeze'
foreach $file (@ARGV) {
	$files = &rcsargs($file);
	@files = split(' ', $files);
	$rlog = `rlog -rlastpat- $files 2>&1`;
	($revs) = ($rlog =~ /selected revisions: (\d+)/);
	if (!$revs) {
		print "$progname: $file has never been checked in--checking in...\n";
		system 'perl', '-S', 'patcil', '-p', $file;
		$revs = 2;		# At least null trunk + new fresh revision
	}
	# Look whether there is a branch
	if ($revs == 1) {
		$rlog = `rlog -r$revbranch $files 2>&1`;
		($revs) = ($rlog =~ /selected revisions: (\d+)/);
		$revs++;	# add the base revision
	}
	# If working file exists, make sure latest version was checked in
	if (-f $file) {
		if ($revs == 1) {
			$delta = `rcsdiff -r$baserev $files 2>/dev/null`;
		} else {
			$delta = `rcsdiff -r$revbranch $files 2>/dev/null`;
		}
		if ($delta ne '') {
			# File changed; check it in.
			system 'perl', '-S', 'patcil', '-p', $file;
			if ($revs > 1) {
				# Have to re-run rlog after a new ci
				$rlog = `rlog -r$revbranch $files 2>&1`;
			}
		}
	}
	# Now assign symbolic revision number
	if ($revs == 1) {
		system 'rcs', "-N$opt_v:$baserev", @files;
	} else {
		($lastrev) = ($rlog =~ /revision $revbranch\.(\d+)/);
		system 'rcs', "-N$opt_v:$revbranch.$lastrev", @files;
	}
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-ahnmV] -v version [filelist]
  -a : all the files in MANIFEST.new
  -h : print this message and exit
  -n : all the files newer than patchlevel.h
  -m : all the modified files (which have been patciled)
  -v : set version number (mandatory)
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/newer.pl >>patname
$grep -v '^;#' ../pl/package.pl >>patname
$grep -v '^;#' ../pl/rcsargs.pl >>patname
$grep -v '^;#' ../pl/tilde.pl >>patname
$grep -v '^;#' ../pl/profile.pl >>patname
chmod +x patname
$eunicefix patname

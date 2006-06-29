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
echo "Extracting pat/patdiff (with variable substitutions)"
cat >patdiff <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patdiff.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.2  1994/01/24  14:30:36  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/19  06:42:35  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:43  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patdiff <<'!NO!SUBS!'

$RCSEXT = ',v' unless $RCSEXT;
$TOPDIR = '';			# We are at top-level directory

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("ahnV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;
&copyright'init($copyright) if -f $copyright;

system 'mkdir', 'bugs' unless -d 'bugs';

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

if ($opt_a) {
	open(MANI,"MANIFEST.new") || die "$progname: can't read MANIFEST.new: $!\n";
	@ARGV = ();
	while (<MANI>) {
		chop;
		($_) = split(' ');
		next if -d;
		push(@ARGV,$_);
	}
	close MANI;
}

foreach $file (@ARGV) {
	next if ($file =~ /^patchlevel.h$/);		# Skip patchlevel.h
	if (! -f $file) {
		print "$progname: $file not found.\n";
		next;
	}
	$files = &rcsargs($file);
	@files = split(' ',$files);
	$new='';
	$revs=0;
	$rlog = `rlog -rlastpat- $files 2>&1`;
	($lastpat) = ($rlog =~ /lastpat: ([\d.]+)/);
	($revs) = ($rlog =~ /selected revisions: (\d+)/);
	if (!$revs) {
		print "$progname: no cil has been done on $file.\n" ;;
	} elsif ($revs == 1) {
		($base) = ($rlog =~ /.*\nrevision\s+(\S+)/);
		($a,$b,$c,$d) = split(/\./,$base);
		if ($d ne '') {
			if (!$opt_n) {
				print
	"$progname: no changes in $file since last patch.  (Did you cil it?)\n";
				next;		# Skip file with no changes
			} else {
				$new='foo';
			}
		} else {
			$revs=0;
			$rlog = `rlog -r$revbranch- $files 2>&1`;
			($revs) = ($rlog =~ /selected revisions: (\d+)/);
			if (!$revs) {
				print
	"$progname: no changes in $file since base version.  (Did you cil it?)\n";
				next;		# Skip file with no changes
			} else {
				($new) = ($rlog =~ /\nrevision\s*(\d+\.\d+\.\d+\.\d+)/);
			}
		}
	} else {
		($new) = ($rlog =~ /\nrevision\s*(\d+\.\d+\.\d+\.\d+)/);
	}
	if ($new ne '') {
		($fname = $file) =~ s|.*/||;
		$fname = substr($fname, 0, 11);		# For filsystems with short names
		open(PATCH,">>bugs/$fname.$bnum") || die "Can't make patch";
		print PATCH "\nIndex: $file\n";
		open(CO,"co -p -rlastpat $files 2>/dev/null |");
		while (<CO>) {
			if (/\$Header/ || /\$Id/) {
				print PATCH "Prereq: $lastpat\n";
				last;
			}
		}
		close CO;
		if (!$opt_n) {
			if ($mydiff eq '') {
				open(DIFF,"rcsdiff -c -rlastpat -r$new $files |") ||
				die "$progname: can't fork rcsdiff: $!\n";
				while (<DIFF>) {
					if ($. == 1) {s|\*\*\* \S+	|*** $file.old	|;}
					if ($. == 2) {s|--- \S+	|--- $file	|;}
					s|Lock[e]r:.*\$|\$|;	# Use [e] to make it safe on itself
					print PATCH;
				}
				close DIFF;
				system 'rcs', "-Nlastpat:$new", @files;
			} else {
				&copyright'expand("co -p -rlastpat $file", "/tmp/pdo$$");
				&copyright'expand("co -p -r$new $file", "/tmp/pdn$$");
				open(DIFF, "$mydiff /tmp/pdo$$ /tmp/pdn$$ |") ||
				die "Can't run $mydiff";
				while (<DIFF>) {			# Contextual or unified diff
					if ($. == 1) {
						s|\*\*\* \S+	|*** $file.old	| ||
						s|--- \S+	|--- $file.old	|;
					}
					if ($. == 2) {
						s|--- \S+	|--- $file	| ||
						s|\+\+\+ \S+	|+++ $file	|;
					}
					s|Lock[e]r:.*\$|\$|;	# Remove locker mark
					print PATCH;
				}
				close DIFF;
				system 'rcs', "-Nlastpat:$new", @files;
				unlink "/tmp/pdn$$", "/tmp/pdo$$";
			}
		} else {
			if ($mydiff eq '') {
				open(DIFF,"rcsdiff -c -rlastpat $files |") ||
				die "Can't run rcsdiff";
				while (<DIFF>) {
					if ($. == 1) {s|\*\*\* \S+	|*** $file.old	|;}
					if ($. == 2) {s|--- \S+	|--- $file	|;}
					s|Lock[e]r:.*\$|\$|;	# Remove locker mark
					print PATCH;
				}
				close DIFF;
			} else {
				system "co -p -rlastpat $files >/tmp/pdo$$";
				system "cp $file /tmp/pdn$$";
				open(DIFF, "$mydiff /tmp/pdo$$ /tmp/pdn$$ |") ||
				die "$progname: can't fork $mydiff: $!\n";
				while (<DIFF>) {
					# Contextual or unified diff
					if ($. == 1) {
						s|\*\*\* \S+	|*** $file.old	|;
						s|--- \S+	|--- $file.old	|;
					}
					if ($. == 2) {
						s|--- \S+	|--- $file	|;
						s|\+\+\+ \S+	|+++ $file	|;
					}
					s|Lock[e]r:.*\$|\$|;	# Remove locker mark
					print PATCH;
				}
				close DIFF;
				unlink "/tmp/pdn$$", "/tmp/pdo$$";
			}
		}
	}
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-ahnV] [filelist]
  -a : all the files in MANIFEST.new
  -h : print this message and exit
  -n : non update mode
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patdiff
$grep -v '^;#' ../pl/rcsargs.pl >>patdiff
$grep -v '^;#' ../pl/copyright.pl >>patdiff
$grep -v '^;#' ../pl/tilde.pl >>patdiff
$grep -v '^;#' ../pl/profile.pl >>patdiff
chmod +x patdiff
$eunicefix patdiff

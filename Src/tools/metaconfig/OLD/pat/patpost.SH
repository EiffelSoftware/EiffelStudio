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
echo "Extracting pat/patpost (with variable substitutions)"
cat >patpost <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patpost.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.4  1995/05/12  12:25:58  ram
# patch54: added explicit From: header line pointing to the maintainer
#
# Revision 3.0.1.3  1994/01/24  14:32:09  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/24  12:19:48  ram
# patch3: added ~name expansion for orgname
# patch3: random cleanup
#
# Revision 3.0.1.1  1993/08/19  06:42:41  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:47  ram
# Baseline for dist 3.0 netwide release.
#

\$inews='${inews-/usr/lib/news/inews}';
\$orgname='$orgname';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!

cat >>patpost <<'!NO!SUBS!'

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("hrV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$RCSEXT = ',v' unless $RCSEXT;
if ($inews eq 'inews') {
	$inews = '/usr/lib/news/inews' if -f '/usr/lib/news/inews';
}

chdir '..' if -d '../bugs';

&readpackage;

$orgname = &tilda_expand($orgname);
chop($orgname = `cat $orgname`) if $orgname =~ m|^/|;

if ($opt_r) {
	$repost = ' (REPOST)';
}

while ($_ = shift) {
	if (/^(patch)?[1-9][\d\-]*$/) {
		s/^patch//;
		push(@argv,$_);
	} else {
		push(@newsgroups,$_);
	}
}
$newsgroups = join(',',@newsgroups) unless $#newsgroups < 0;
&usage unless $newsgroups;

@ARGV = @argv;
open(PL,"patchlevel.h") || die "$progname: can't open patchlevel.h: $!\n";
while (<PL>) {
	$maxnum = $1 if /^#define\s+PATCHLEVEL\s+(\d+)/;
}
close PL;
die "$progname: malformed patchlevel.h file.\n" if $maxnum eq '';

if ($#ARGV < 0) {
	@patseq = &patseq($maxnum);
	$lastpat = pop(@patseq);
	$argv = &rangeargs("$lastpat-$maxnum");
}
else {
	$argv = &rangeargs(@ARGV);
}

@ARGV = split(' ',$argv);
$argv =~ s/ $//;

if ($#ARGV < 0) {
	print STDERR "$progname: no patches specified.\n";
	&usage;
} elsif ($#ARGV) {
	print
	"$progname: posting $package $baserev patches $argv to $newsgroups...\n";
} else {
	print
	"$progname: posting $package $baserev patch $argv to $newsgroups...\n";
}

chdir 'bugs' || die "$progname: can't cd to bugs: $!\n";

fork && exit;

until ($#ARGV < 0) {
	$patnum = shift;
	open(PATCH,"patch$patnum") ||
		die "$progname: can't open patch$patnum: $!\n";
	open(XHEAD,"|$inews -h") || die "$progname: can't fork $inews: $!\n";
	print XHEAD
"From: $maintloc ($maintname)
Newsgroups: $newsgroups
Subject: $package $baserev patch #$patnum$repost
Summary: This is an official patch for $package $baserev.  Please apply it.
Expires: 
References: 
Sender: 
Distribution: 
Organization: $orgname
Keywords: 

";
	while (<PATCH>) {
		print XHEAD;
	}
	close PATCH;
	close XHEAD;
	die "$progname: could not post patch$patnum.\n" if $?;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hrV] patchlist newsgroups
  -h : print this message and exit
  -r : signals a repost
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patpost
$grep -v '^;#' ../pl/rangeargs.pl >>patpost
$grep -v '^;#' ../pl/patseq.pl >>patpost
$grep -v '^;#' ../pl/tilde.pl >>patpost
$grep -v '^;#' ../pl/profile.pl >>patpost
chmod +x patpost
$eunicefix patpost

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
echo "Extracting pat/patsend (with variable substitutions)"
cat >patsend <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patsend.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.6  1995/09/25  09:22:02  ram
# patch59: new -i option to add more instructions for end-users
#
# Revision 3.0.1.5  1994/01/24  14:32:46  ram
# patch16: now prefix error messages with program's name
# patch16: don't feed mailer with more than 50 addresses at a time
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.4  1993/08/25  14:08:01  ram
# patch6: now asks for recipient list edition by default
# patch6: new -q option to suppress that
#
# Revision 3.0.1.3  1993/08/24  12:21:59  ram
# patch3: new -u option
# patch3: added Precedence and X-Mailer headers in mail message
# patch3: added ~name expansion for orgname
#
# Revision 3.0.1.2  1993/08/19  07:10:19  ram
# patch3: was not correctly writing the To: header field
#
# Revision 3.0.1.1  1993/08/19  06:42:42  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:49  ram
# Baseline for dist 3.0 netwide release.
#

\$orgname='$orgname';
\$mailer='$mailer';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patsend <<'!NO!SUBS!'

$progname = &profile;			# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("hiquV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

chdir '..' if -d '../bugs';

&readpackage;
&readusers if $opt_u;

$orgname = &tilda_expand($orgname);
chop($orgname = `cat $orgname`) if $orgname =~ m|^/|;

while ($_ = shift) {
	if (/^(patch)?[1-9][\d,-]*$/) {
		s/^patch//;
		push(@argv,$_);
	} else {
		push(@dest,$_);
	}
}
$dest = join(' ',@dest);
$dest .= " $recipients" if $opt_u;
&usage unless $dest;

# Offer to edit the address list unless -q
unless ($opt_q) {
	select((select(STDOUT), $| = 1)[0]);
	print "Do you wish to edit the address list? [y] ";
	$ans = <STDIN>;
	unless ($ans =~ /^n/i) {
		@to = split(' ', $dest);
		&listedit(*to);
		$dest = join(' ', @to);
	}
}

$to = join(', ', split(' ', $dest));
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
} else {
	$argv = &rangeargs(@ARGV);
}

@ARGV = split(' ',$argv);
$argv =~ s/ $//;

if ($#ARGV < 0) {
	print STDERR "$progname: no patches specified.\n";
	&usage;
} elsif ($#ARGV) {
	print "$progname: sending $package $baserev patches $argv to $dest...\n";
} else {
	print "$progname: sending $package $baserev patch $argv to $dest...\n";
}

chdir 'bugs' || die "$progname: can't cd to bugs: $!\n";

fork && exit;

$opt = '-odq' if $mailer =~ /sendmail/;

until ($#ARGV < 0) {
	$patnum = shift;

	# I hate broken mailers! Bust it up into smaller groups of people...
	@dest = split(' ', $dest);
	while (@smalldest = splice(@dest, 0, 50)) {
		$to = join(', ', @smalldest);	# Sensible To: for sendmail
		$smalldest = join(' ', @smalldest);

		open(MAILER, "|$mailer $opt $smalldest") ||
			die "$progname: can't fork $mailer: $!\n";
		print MAILER
"To: $to
Subject: $package $baserev patch #$patnum
Precedence: bulk
X-Mailer: dist [version $version PL$patchlevel]
Organization: $orgname

";
		print MAILER
"$package version $baserev has been recently upgraded with the following patch,
which is being mailed directly to you as you requested when running Configure.

If you are not interested in having future patches mailed directly to you,
please send me the following mail:

	Subject: Command
	\@SH package - $package $baserev

-- $progname speaking for $maintname <$maintloc>.

" if ($opt_i || $opt_u);
		print MAILER
"[The latest patch for $package version $baserev is #$maxnum.]

";
		open(PATCH,"patch$patnum") ||
			die "$progname: can't open patch$patnum: $!\n";
		while (<PATCH>) {
			print MAILER;
		}
		close PATCH;
		close MAILER;
		die "$progname: could not mail patch$patnum.\n" if $?;
	}
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hiquV] [patchlist] [recipients]
  -h : print this message and exit
  -i : include information on how to stop receiving future patches
  -q : quick mode, do not offer to edit recipient list
  -u : add all to-be-mailed users
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patsend
$grep -v '^;#' ../pl/rangeargs.pl >>patsend
$grep -v '^;#' ../pl/users.pl >>patsend
$grep -v '^;#' ../pl/patseq.pl >>patsend
$grep -v '^;#' ../pl/tilde.pl >>patsend
$grep -v '^;#' ../pl/editor.pl >>patsend
$grep -v '^;#' ../pl/listedit.pl >>patsend
$grep -v '^;#' ../pl/profile.pl >>patsend
chmod +x patsend
$eunicefix patsend

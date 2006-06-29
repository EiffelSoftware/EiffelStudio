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
echo "Extracting kit/kitsend (with variable substitutions)"
cat >kitsend <<!GROK!THIS!
$startperl
	eval 'exec perl -S \$0 "\$@"'
		if \$running_under_some_shell;

# $Id: kitsend.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# Original Author: Harlan Stenn <harlan@mumps.pfcs.com>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.2  1994/05/06  13:59:57  ram
# patch23: random code cleanup to follow pat tools style
# patch23: made configurable from dist profile
# patch23: now understands -V and -h options
# patch23: mails now flagged with a bulk precedence
# patch23: added X-Mailer header and now calls mailer via open()
#
# Revision 3.0.1.1  1993/08/19  06:42:15  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:25  ram
# Baseline for dist 3.0 netwide release.
#

\$orgname='$orgname';
\$mailer='$mailer';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>kitsend <<'!NO!SUBS!'

$progname = &profile;		# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts('hV');

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$orgname = &tilda_expand($orgname);
chop($orgname = `cat $orgname`) if $orgname =~ m|^/|;

&readpackage;

while ($_ = shift) {
	if (/^(kit)?[1-9][\d,-]*$/) {
		s/^kit//;
		push(@argv, $_);
	}
	else {
		push(@dest, $_);
	}
}
$dest = join(' ',@dest);
&usage unless $dest;

@ARGV = @argv;

if (-f "$package.kit10") {
	@filelist = <$package.kit[0-9][0-9]>;
}
else {
	@filelist = <$package.kit[0-9]>;
}
pop(@filelist) =~ /(\d+)$/ && ($maxnum = $1 + 0);

if ($#ARGV < 0) {
	$argv = "1-$maxnum";
	@ARGV = $argv;
}
$argv = &rangeargs(@ARGV);
@ARGV = split(' ', $argv);

$argv =~ s/ $//;

if ($#ARGV < 0) {
	die "$progname: no kits specified.\n";
} elsif ($#ARGV) {
	print "$progname: sending $package $baserev kits $argv to $dest...\n";
} else {
	print "$progname: sending $package $baserev kit $argv to $dest...\n";
}

fork && exit;

$opt = '-odq' if $mailer =~ /sendmail/;

until ($#ARGV < 0) {
	$kitnum = shift;

	# Provision for broken mailers...
	@dest = split(' ', $dest);
	while (@smalldest = splice(@dest, 0, 50)) {
		$to = join(', ', @smalldest);	# Sensible To: for sendmail
		$smalldest = join(' ', @smalldest);

		open(MAILER, "|$mailer $opt $smalldest") ||
			die "$progname: can't fork $mailer: $!\n";
		print MAILER
"To: $to
Subject: $package $baserev kit #$kitnum
Precedence: bulk
X-Mailer: dist [version $version PL$patchlevel]
Organization: $orgname

[There are $maxnum kits for $package version $baserev.]

";
		$kitnum = "0$kitnum" if $kitnum < 10 && $maxnum >= 10;
		open(FILE,"$package.kit$kitnum") ||
			die "$progname: can't open $package.kit$kitnum: $!\n";
		while (<FILE>) {
			print MAILER;
		}
		close FILE;
		close MAILER;
		warn "$progname: ERROR mailing of $package.kit$kitnum to $dest\n" if $?;
	}
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hV] [kits] dest
  -h : print this message and exit
  -V : print version number and exit
EOM
	exit 1;
}

sub rangeargs {
	local($result) = '';
	local($min,$max,$_);
	while ($#_ >= 0) {
		$_ = shift(@_);
		while (/^\s*\d/) {
			s/^\s*(\d+)//;
			$min = $1;
			if (s/^,//) {
				$max = $min;
			}
			elsif (s/^-(\d*)//) {
				$max = $1;
				if ($max == 0 && $maxnum) {
					$max = $maxnum;
				}
				s/^[^,],?//;
			}
			else {
				$max = $min;
			}
			for ($i = $min; $i <= $max; ++$i) {
				$result .= $i . ' ';
			}
		}
	}
	$result;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>kitsend
$grep -v '^;#' ../pl/tilde.pl >>kitsend
$grep -v '^;#' ../pl/profile.pl >>kitsend
chmod +x kitsend
$eunicefix kitsend

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
echo "Extracting kit/kitpost (with variable substitutions)"
cat >kitpost <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: kitpost.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.2  1994/10/29  15:48:26  ram
# patch36: don't use rootid as a variable, it is known by metaconfig
#
# Revision 3.0.1.1  1994/05/06  13:54:53  ram
# patch23: created
#

\$inews='${inews-/usr/lib/news/inews}';
\$mailer='$mailer';
\$orgname='$orgname';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!

cat >>kitpost <<'!NO!SUBS!'

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("hrVm:D:H:");

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
	if (/^(kit)?[1-9][\d\-]*$/) {
		s/^kit//;
		push(@argv,$_);
	} else {
		push(@ngroups,$_);
	}
}
$ngroups = join(',',@ngroups) unless $#ngroups < 0;
$dest = $opt_m;
&usage unless $ngroups || $dest;

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
	print STDERR "$progname: no kits specified.\n";
	&usage;
} else {
	local($s) = $#ARGV ? 's' : '';
	print "$progname: posting $package $baserev kit$s $argv to $ngroups...\n"
		if $ngroups;
	print "$progname: mailing $package $baserev kit$s $argv to $dest...\n"
		if $dest;
}

$desc = "$opt_D, " if $opt_D;

fork && exit;

# Compute a suitable root message ID that all parts will reference, so that
# threaded news readers will correctly process them.
# Unfortunately, this works only when all kits are sent.
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
	localtime(time);
$mon++;
$rootmid = "$year$mon$mday$hour$min$sec.AA$$";
$first = $maxnum >= 10 ? "01" : "1";
$rootmsgid = "<$rootmid.P$first.$maintloc>";

until ($#ARGV < 0) {
	$kitnum = shift;
	$kitnum = "0$kitnum" if $kitnum < 10 && $maxnum >= 10;
	open(FILE, "$package.kit$kitnum") ||
		die "$progname: can't open $package.kit$kitnum: $!\n";
	if ($ngroups) {
		open(INEWS,"|$inews -h") || die "$progname: can't fork $inews: $!\n";
	}
	if ($dest) {
		$opt = '-odq' if $mailer =~ /sendmail/;
		$dest =~ s/,/ /g;
		($to = $dest) =~ s/\s+/, /g;
		open(MAILER,"|$mailer $opt $dest") ||
			die "$progname: can't fork $mailer: $!\n";
	}

	$msg_id = "<$rootmid.P$kitnum.$maintloc>";
	$msg_id = $rootmsgid if $kitnum == 1;
	$msg_id .= "\nReferences: $rootmsgid" if $kitnum != 1;

	print INEWS "Newsgroups: $ngroups\n";
	print MAILER "To: $to\n";
$head = <<EOH;
Subject: $package $baserev - ${desc}part$kitnum/$maxnum$repost
Message-ID: $msg_id
Organization: $orgname

Submitted-by: $maintname <$maintloc>
Archive-name: $package-$baserev/part$kitnum
Environment: UNIX

EOH
	print INEWS $head;
	print MAILER $head;

	if ($kitnum == 1 && $opt_H) {
		open(HEAD, $opt_H) || warn "$progname: can't open $opt_H: $!\n";
		while (<HEAD>) {
			print INEWS;
			print MAILER;
		}
		close HEAD;
	}

	while (<FILE>) {
		print INEWS;
		print MAILER;
	}
	close FILE;
	close INEWS;
	die "$progname: could not post part$kitnum.\n" if $ngroups && $?;
	close MAILER;
	die "$progname: could not send part$kitnum.\n" if $dest && $?;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hrV] [-H file] [-D desc] [-m dest1,dest2] [kits] [newsgroups]
  -h : print this message and exit
  -m : set-up recipients for (additional) mailing
  -r : signals a repost
  -D : specify description string for subject line
  -H : specify file to be used as header for first part
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
$grep -v '^;#' ../pl/package.pl >>kitpost
$grep -v '^;#' ../pl/tilde.pl >>kitpost
$grep -v '^;#' ../pl/profile.pl >>kitpost
chmod +x kitpost
$eunicefix kitpost

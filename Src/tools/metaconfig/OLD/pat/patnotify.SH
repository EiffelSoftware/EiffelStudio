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
echo "Extracting pat/patnotify (with variable substitutions)"
cat >patnotify <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patnotify.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.9  1997/02/28  16:33:35  ram
# patch61: let them know the patch priority and description
#
# Revision 3.0.1.8  1995/09/25  09:21:43  ram
# patch59: now tells users how to directly request for mailed patches
#
# Revision 3.0.1.7  1994/10/29  16:43:19  ram
# patch36: added various escapes in strings for perl5 support
#
# Revision 3.0.1.6  1994/06/20  07:11:47  ram
# patch30: patnotify now includes the e-mail address for requests
#
# Revision 3.0.1.5  1994/01/24  14:31:48  ram
# patch16: now prefix error messages with program's name
# patch16: don't feed mailer with more than 50 addresses at a time
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.4  1993/08/27  14:40:42  ram
# patch7: two files were wrongly appended to patsend instead
#
# Revision 3.0.1.3  1993/08/25  14:07:43  ram
# patch6: now asks for recipient list edition by default
# patch6: new -q option to suppress that
#
# Revision 3.0.1.2  1993/08/24  12:48:03  ram
# patch5: fixed fatal typo in here document
#
# Revision 3.0.1.1  1993/08/24  12:19:11  ram
# patch3: created
#

\$defeditor='$defeditor';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
\$mailer = '$mailer';
!GROK!THIS!
cat >>patnotify <<'!NO!SUBS!'

$progname = &profile;			# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("hquV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

chdir '..' if -d '../bugs';

&readpackage;
&readusers if $opt_u;

$dest = join(' ', @ARGV);
$dest .= " $notify" if $opt_u;

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

if (-f 'patchlevel.h') {
	open(PL,"patchlevel.h") || die "$progname: can't open patchlevel.h: $!\n";
	while (<PL>) {
		if (/^#define\s+PATCHLEVEL\s+(\d+)/) {
			$last = $1;
		}
	}
	die "$progname: malformed patchlevel.h file.\n" if $last eq '';
} else {
	die "$progname: no patchlevel.h.\n";
}

@patches = &patseq($last);	# Compute patches sequence
$lastpat = pop(@patches);

warn "$progname: missing last .logs and .mods files\n" if $lastpat eq '';

$missing = $last - $lastpat + 1;
$these = $missing == 1 ? 'this' : 'these';
$patches = $missing == 1 ? 'patch' : 'patches';
$through = $missing == 1 ? $lastpat : "$lastpat thru " . ($lastpat+$missing-1);
$have = $missing == 1 ? 'has' : 'have';
$patlist = "$lastpat-";		# They'll get everything up to the end

($Patches = $patches) =~ s/^p/P/;
$opt = ($mailer =~ /sendmail/) ? '-odq' : '';

chdir 'bugs' || die "$progname: can't cd to bugs: $!\n";

# Find out priority of last patch set
$priority = 'UNKNOWN';
open(PATCH, "patch$lastpat") ||
	die "$progname: can't open patch #$lastpat: $!\n";
while (<PATCH>) {
	/^Priority:\s*(\S+)\s*$/ && ($priority = $1);
}
close PATCH;

# Look for the .clog<patch #> description and prepare the patch description
# for inclusion in the notification, so that they can figure out whether
# they really need that patch set.

if (-f ".clog$lastpat") {
	open(LOGS, ".clog$lastpat") ||
		die "$progname: can't open .clog$lastpat: $!\n";
	$_ = <LOGS> . <LOGS> . <LOGS>;	# Skip first three lines
	$clog = '';
	while (<LOGS>) {
		$clog .= $_;
	}
	close LOGS;
} else {
	warn "$progname: missing last .clog file in bugs directory\n";
}

print "$progname: sending notification of $missing new $patches to $dest...\n";

fork && exit;

# I hate broken mailers! Bust it up into smaller groups of people...
@dest = split(' ', $dest);
while (@smalldest = splice(@dest, 0, 50)) {
	$to = join(', ', @smalldest);	# Sensible To: for sendmail
	$smalldest = join(' ', @smalldest);

	open(MAILER, "|$mailer $opt $smalldest") ||
		die "$progname: can't fork $mailer: $!\n";
	print MAILER
"To: $to
Subject: $Patches $through for $package version $baserev $have been released.
Precedence: bulk
X-Mailer: dist [version $version PL$patchlevel]

This is just a quick note to let you know that $package version $baserev
has been recently upgraded and that $patches $through $have been released.

If you are actively using $package, I strongly suggest you upgrade by
applying $these $patches, whose priority is $priority.

You can fetch $these $patches automatically by sending me the following mail:

	Subject: Command
	\@SH mailpatch - $package $baserev $patlist
		   ^ note the c

And if you wish to have future patches mailed directly to you, you can add:

	\@SH package - $package $baserev - mailpatches

If you are not interested in receiving any information about future patches,
please send me the following mail:

	Subject: Command
	\@SH package - $package $baserev
";
	print MAILER
"
Following is the $patches description:

$clog" if $clog;
	print MAILER
"
-- $progname speaking for $maintname <$maintloc>.
";
	close MAILER;
}

sub usage {
	print STDERR <<EOH;
Usage: $progname [-hquV] [recipients]
  -h : print this message and exit
  -q : quick mode, do not offer to edit recipient list
  -u : add all to-be-notified users
  -V : print version number and exit
EOH
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patnotify
$grep -v '^;#' ../pl/users.pl >>patnotify
$grep -v '^;#' ../pl/patseq.pl >>patnotify
$grep -v '^;#' ../pl/editor.pl >>patnotify
$grep -v '^;#' ../pl/listedit.pl >>patnotify
$grep -v '^;#' ../pl/tilde.pl >>patnotify
$grep -v '^;#' ../pl/profile.pl >>patnotify
chmod +x patnotify
$eunicefix patnotify

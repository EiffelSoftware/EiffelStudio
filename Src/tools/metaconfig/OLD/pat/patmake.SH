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
echo "Extracting pat/patmake (with variable substitutions)"
cat >patmake <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patmake.SH 78389 2004-11-30 00:17:17Z manus $
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
# Contribution by: Graham Stoney <greyham@research.canon.oz.au>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.5  1995/09/25  09:21:19  ram
# patch59: now calls patsend with -i to add more instructions
#
# Revision 3.0.1.4  1994/10/29  16:43:09  ram
# patch36: a lot of setup is now performed by patlog
# patch36: added various escapes in strings for perl5 support
#
# Revision 3.0.1.3  1994/01/24  14:30:55  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/24  12:18:59  ram
# patch3: now asks for patch mailing/posting after all patches edited
# patch3: patch release notification is done via new patnotify
# patch3: random cleanup, removed old RCS logs
#
# Revision 3.0.1.1  1993/08/19  06:42:38  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:45  ram
# Baseline for dist 3.0 netwide release.
#

\$defeditor='$defeditor';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
\$mailer = '$mailer';
!GROK!THIS!
cat >>patmake <<'!NO!SUBS!'

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("hV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;
&readusers;

$FILEOVERHEAD = 40;		# Name of files, Index, Prereq
$MAXPATSIZE = 50000;	# Maximum allowed size for a patch
$PATOVERHEAD = 2500;	# Litterature
$FIRST_PAT = 3000;		# Give space for first patch (descriptions)

if (-f 'patchlevel.h') {
	open(PL,"patchlevel.h") || die "$progname: can't open patchlevel.h: $!\n";
	while (<PL>) {
		if (/^#define\s+PATCHLEVEL\s+(\d+)/) {
			$last = $1;
			$patchline = $.;	# Record PATCHLEVEL line
		}
	}
	die "$progname: malformed patchlevel.h file.\n" if $last eq '';
	$bnum = $last + 1;
}
else {
	$patchline = 1;
	$bnum = 1;
	$last = '';
}

@ARGV = <[Mm]akefile*>;
$mf = '';
if ($#ARGV > 0) {
	while (<>) {
		$mf .= $_ if /^[a-z.]+\s*:/;	# Rules in makefile
	}
}
$* = 1;
$after = '';
$after .= "\t\tConfigure -ders\n" if -f 'Configure';
$after .= "\t\tmake depend\n" if $mf =~ /^depend:/;
$after .= "\t\tmake\n" if $mf;
$after .= "\t\tmake test\n" if $mf =~ /^test:/;
$after .= "\t\tmake install\n" if $mf =~ /^install:/;
$after .= "\t\tmake install.man\n" if $mf =~ /^install\.man:/;
$* = 0;

chdir 'bugs' if -d 'bugs';
die "$progname: patch #$bnum already exists.\n" if -f "patch$bnum";

@patlist=<*.$bnum>;
die "$progname: no diff files for patch #$bnum.\n" if
	$patlist[0] =~ /^\*/ || $patlist[0] eq '';

# Whether they asked for a changelog file or not, call patlog.
# This will create at least the .pri and .subj and .clog files that we need.
# If a changelog file is needed, it will update it and create the necessary
# patch before we go on and put all those patches together.
# Note that we make use of the '-r' option, in case they have already
# run patlog themselves and made the necessary adjustments. Since -r supersedes
# -u, it's safe to allow ~/.dist_profile processing anyway.

chdir '..' if -d '../bugs';
system 'perl', '-S', 'patlog', '-r';	# Must be called from top-level dir
chdir 'bugs' if -d 'bugs';

@patlist=<*.$bnum>;		# Reget it, in case Changes.xx appeared due to patlog

# Look for size of each diff file
for (@patlist) {
	($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,
		$blksize,$blocks) = stat($_);
	$size{$_} = $size;
}

# Sort the array, biggest sizes first
sub revnum { $size{$a} < $size{$b} ? 1 : $size{$a} > $size{$b} ? -1 : 0; }
@patlist = sort revnum @patlist;

# Put files in a patch
for (@patlist) {
	$i=1;
	# Find the patch in which the current file can go
	# Divide size by 15 to count the 3 spaces added in front of each line
	while (($newtot = int($tot[$i] + $size{$_} + $size{$_}/15 + $FILEOVERHEAD)) >
			$MAXPATSIZE-$PATOVERHEAD-($i == 1 ? $FIRST_PAT : 0) && $tot[$i]) {
		$i++;
	}
	# Adding $_ to patch $i giving $newtot bytes
	$tot[$i] = $newtot;		# Update size of kit $i
	$list[$i] .= " $_";		# Add file to the kit $i
}

$numpat = $#list;		# Number of patches to generate

if ($numpat > 1) {
	print "$progname: Warning: generating $numpat patches.\n";
	sleep(1);
}

$hah = " (hah!)" if $bnum == 1;
$patbase = $bnum;			# First patch generated

open(PRIORITY, ".pri$bnum");
chop($priority = <PRIORITY>);
close PRIORITY;
$priority = 'LOW' unless $priority;

for ($i = 1; $i <= $numpat; $i++) {		# For all patches...
	open(PATCH,">patch$bnum") || die "Can't create patch #$bnum";
	chop($date=`date`);
	print PATCH
"System: $package version $baserev
Patch #: $bnum
";
	print PATCH "Priority: $priority\n" unless $priority eq '';
	# Print subjects only for first patch
	if ($i == 1) {
		open(SUBJECTS, ".subj$bnum");
		print PATCH while <SUBJECTS>;
		close SUBJECTS;
	} else {
		print PATCH "Subject: patch #$patbase, continued\n";
	}
	print PATCH
"Date: $date
From: $maintname <$maintloc>

Description:
";
	# Print description and repeat-by only for first patch
	if ($i == 1) {
		open(LOGS, ".clog$bnum");
		$_ = <LOGS>; $_ = <LOGS>; $_ = <LOGS>;	# Skip first three lines
		print PATCH while <LOGS>;
		close LOGS;
		print PATCH "Repeat-By: \n";
	} else {
		print PATCH "\tSee patch #$patbase.\n\n";
	}
	print PATCH
"
Fix:	From rn, say \"| patch -p -N -d DIR\", where DIR is your $package source
	directory.  Outside of rn, say \"cd DIR; patch -p -N <thisarticle\".
	If you don't have the patch program, apply the following by hand,
	or get patch (version 2.0, latest patchlevel).

	After patching:
";
	# Do $after only after last patch
	if ($i == $numpat) {
		print PATCH $after;
	} else {
		printf PATCH
"\t\t*** DO NOTHING--INSTALL ALL PATCHES UP THROUGH #%d FIRST ***\n",
$patbase + $numpat - 1;
	}
	print PATCH "
	If patch indicates that patchlevel is the wrong version, you may need
	to apply one or more previous patches, or the patch may already
	have been applied.  See the patchlevel.h file to find out what has or
	has not been applied.  In any event, don't continue with the patch.

	If you are missing previous patches$hah they can be obtained from me:

		$maintname <$maintloc>

";
	if ($mailagent ne 'false') {
		print PATCH
"	If you send a mail message of the following form it will greatly speed
	processing:

		Subject: Command
		\@SH mailpatch PATH $package $baserev LIST
			   ^ note the c

	where PATH is a return path FROM ME TO YOU either in Internet notation,
	or in bang notation from some well-known host, and LIST is the number
	of one or more patches you need, separated by spaces, commas, and/or
	hyphens.  Saying 35- says everything from 35 to the end.

	To get some more detailed instructions, send me the following mail:

		Subject: Command
		\@SH mailhelp PATH

";
	}
	if ($ftpsite) {
		print PATCH
"	You can also get the patches via anonymous FTP from
	$ftpsite.
";
	}
	# Print patchlevel at the top of each patch
	print PATCH "
Index: patchlevel.h
";
	if ($last eq '') {
		`echo "#define PATCHLEVEL 1" >patchlevel.h`;
		`cp /dev/null patchlevel.h.null`;
		print PATCH `diff -c patchlevel.h.null patchlevel.h`;
		unlink 'patchlevel.h', 'patchlevel.h.null';
	}
	else {
		print PATCH
"Prereq: $last
${patchline}c${patchline}
< #define PATCHLEVEL $last
---
> #define PATCHLEVEL $bnum
";
	}
	$last = $bnum;			# Update last patch
	push(@patset, $bnum);	# Record set of generated patch(es)

	@ARGV = split(' ', $list[$i]);
	while (<>) { print PATCH; }
	print PATCH "\n*** End of Patch $bnum ***\n";
	close PATCH;

	# Update patchlevel.h file
	$editor = $ENV{'VISUAL'};
	$editor = $ENV{'EDITOR'} unless $editor;
	$editor = $defeditor unless $editor;
	$editor = 'vi' unless $editor;
	system $editor, "patch$bnum";
	if (-s "patch$bnum") {
		system 'chmod', '-w', "patch$bnum";		# Protect newly created patch
		chdir '..';
		`echo "#define PATCHLEVEL 0" >patchlevel.h` unless -f 'patchlevel.h';
		open(PL,"patchlevel.h") ||
			die "$progname: can't open patchlevel.h: $!\n";
		open(PLN,">patchlevel.h+") ||
			die "$progname: can't create new patchlevel.h: $!\n";
		while (<PL>) {
			if (/^#define\s+PATCHLEVEL\s+(\d+)/) {
				$bnum = $1;
				$bnum++;		# Update patch level
				print PLN "#define PATCHLEVEL $bnum\n";
			} else {
				print PLN;		# Simply copy other lines
			}
		}
		close PLN;
		close PL;
		`mv -f patchlevel.h+ patchlevel.h`;
		die "$progname: malformed patchlevel.h file.\n" if $bnum eq '';
	} else {
		unlink "patch$bnum";
		die "$progname: aborted.\n";
	}

	chdir 'bugs' || die "$progname: cannot cd to bugs: $!\n";
	
	# Find priority for next patch in loop
	$priority='';
	open(PATCH, "patch$bnum") || die "Cannot re-open patch #$bnum !\n";
	while (<PATCH>) {
		/^Priority:\s*(\S+)\s*$/ && ($priority = $1);
	}
	close PATCH;

	$bnum++;	# For next patch in loop
}

utime time, time, 'patchlevel.h';	# Reset timestamp on patchlevel

if (@patset == 1) {
	$bnum = pop(@patset);
	$patch = "patch #$bnum";
} else {
	$bmin = shift(@patset);
	$bmax = pop(@patset);
	$bnum = "$bmin-$bmax";
	$patch = "patches #$bmin thru #$bmax";
}

# Post generated patches
if ($newsgroups) {
	print "\nDo you wish to post $patch to $newsgroups? [y] ";
	$ans = <stdin>;
	system 'patpost', $bnum unless $ans =~ /^n/i;
}

# Mail generated patches
if ($recipients) {
	print "\n";
	if (0 == ($recipients =~ tr/ //)) {
		print "Do you wish to send $patch to $recipients? [y] ";
	} else {
		print "The following people are on the recipient list:\n\n";
		foreach $addr (split(' ', $recipients)) {
			print "\t$addr\n";
		}
		print "\nDo you wish to send $patch to them? [y] ";
	}
	$ans = <stdin>;
	system 'patsend', '-i', $bnum, $recipients unless $ans =~ /^n/i;
}

# Copy patches to FTP directory
if ($ftpdir) {
	print "\nDo you wish to copy $patch to $ftpdir? [y] ";
	$ans = <stdin>;
	system 'patftp', $bnum unless $ans =~ /^n/i;
}

# Notify people about it.
if ($notify) {
	print "\n";
	if (0 == ($notify =~ tr/ //)) {
		print "Do you wish to notify $notify? [y] ";
	} else {
		print "The following people are on the notify list:\n\n";
		foreach $addr (split(' ', $notify)) {
			print "\t$addr\n";
		}
		print "\nDo you wish to notify them? [y] ";
	}
	$ans = <STDIN>;
	system 'patnotify', $notify unless $ans =~ /^n/i;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hV]
  -h : print this message and exit
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patmake
$grep -v '^;#' ../pl/users.pl >>patmake
$grep -v '^;#' ../pl/tilde.pl >>patmake
$grep -v '^;#' ../pl/profile.pl >>patmake
chmod +x patmake
$eunicefix patmake

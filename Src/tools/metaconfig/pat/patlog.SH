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
echo "Extracting pat/patlog (with variable substitutions)"
cat >patlog <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patlog.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.2  1997/02/28  16:33:03  ram
# patch61: typo fix
#
# Revision 3.0.1.1  1994/10/29  16:42:26  ram
# patch36: created
#

\$defeditor='$defeditor';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patlog <<'!NO!SUBS!'

$progname = &profile;	# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("hnruV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

&readpackage;

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

chdir 'bugs' if -d 'bugs';

die "$progname: patch #$bnum already exists.\n" if -f "patch$bnum";

@patlist=<*.$bnum>;
die "$progname: no diff files for patch #$bnum.\n" if
	$patlist[0] =~ /^\*/ || $patlist[0] eq '';

# Set up a proper editor, for later perusal
$editor = $ENV{'VISUAL'};
$editor = $ENV{'EDITOR'} unless $editor;
$editor = $defeditor unless $editor;
$editor = 'vi' unless $editor;

# The following used to be done in patmake. Only we do not really need to
# compute the subject lines for the generated patch here, we do it nonetheless
# to avoid code duplication in patmake.

if (-s ".logs$bnum") {
	$logs = '';
	open(LOGS,".logs$bnum");
	while (<LOGS>) {
		unless ($logseen{$_}) {
			$logs .= $_;
			$logseen{$_}++;
			$logsnum++;			# One more log
		}
	}
	close LOGS;
	$* = 1;
	$subj = $logs;
	$logs =~ s/^patch\d+:\s*/\t/g;
	$logs =~ s/\n/\n\n/g;
	$subj =~ s/^patch\d+:\s*/Subject: /g;
	$* = 0;
} else {
	$subj = "Subject: \n";
}

# Try to guess the priority of the patch
if (-s ".mods$bnum") {
	open(MODS, ".mods$bnum");
	while (<MODS>) {
		chop;
		unless ($fileseen{$_}) {
			$fileseen{$_}++;
			$modsnum++;			# One more modified file
		}
	}
	close MODS;
}
$modsnum++ unless $modsnum;		# Avoid divisions by zero
$mean = $logsnum / $modsnum;
if ($mean > 0.7 && $mean < 1.3) {
	$priority = "MEDIUM";
} elsif ($mean <= 0.7) {
	$priority = "HIGH";		# Small changes
} else {
	$priority = "LOW";		# Big changes
}

# Save priority for patmake
open(PRIORITY, ">.pri$bnum") || die "$progname: can't create .pri$bnum: $!\n";
print PRIORITY $priority, "\n";
close PRIORITY;

# Save subject lines for patmake
open(SUBJECTS, ">.subj$bnum") || die "$progname: can't create .subj$bnum: $!\n";
print SUBJECTS $subj;
close SUBJECTS;

#
# Generate description file, then edit it so that the user may fixup things.
#

unless (($opt_r && -f ".clog$bnum") || ($opt_u && &uptodate(".clog$bnum"))) {
	open(CHANGES, ">.clog$bnum") ||
		die "$progname: can't create .clog$bnum: $!\n";
	print CHANGES <<EOM;
Edition of the Description section for patch #$bnum.
Please leave those three lines here, they will be removed automatically.
------------------------------------------------------------------------
EOM
	print CHANGES $logs;
	close CHANGES;
}

# If they don't want to maintain a ChangeLog file, that's it. They'll get
# the old behaviour where the description is edited directly from within
# the generated patch.

exit(0) if $changelog =~ /^\s*$/;

system $editor, ".clog$bnum";

#
# Generate RCS log file.
#

if ($changercs) {
	unless (
		($opt_r && -f ".rlog$bnum") || ($opt_u && &uptodate(".rlog$bnum"))
	) {
		&buildlogs;
		open(RCS, ">.rlog$bnum") ||
			die "$progname: can't create .rlog$bnum: $!\n";
		print RCS <<EOM;
Edition of the RCS log section for $changelog (patch #$bnum).
Please leave those three lines here, they will be removed automatically.
------------------------------------------------------------------------
EOM
		foreach $key (sort keys %rcslog) {
			print RCS &format('* ' . $rcslog{$key}), "\n";
		}
		close RCS;
	}
	system $editor, ".rlog$bnum";
}

#
# Final logfile entry generation
#

chop($date=`date`);

unless (
	($opt_r && -f ".xlog$bnum") ||
	($opt_u && &uptodate(".xlog$bnum") && !&newertmp)
) {
	open(LOG, ">.xlog$bnum") || die "$progname: can't create .xlog$bnum: $!\n";
	print LOG <<EOM;
Edition of the $changelog entry for patch #$bnum.
Please leave those three lines here, they will be removed automatically.
------------------------------------------------------------------------
EOM
	print LOG "$date   $maintname <$maintloc>\n\n";
	print LOG ". Description:\n\n";
	&addlog(".clog$bnum");
	if ($changercs) {
		print LOG ". Files changed:\n\n";
		&addlog(".rlog$bnum");
	}
	close LOG;
}
system $editor, ".xlog$bnum";
exit(0) if $opt_n;

#
# Changelog file update, checking in and diff computation.
#

print "$progname: updating $changelog...\n";

chdir('..') || die "$progname: can't go back to ..: $!\n";
if (-f $changelog) {
	rename($changelog, "$changelog.bak") ||
		die "$progname: can't rename $changelog into $changelog.bak: $!\n";
}

open(LOG, ">$changelog") || die "$progname: can't create $changelog: $!\n";
&addlog("bugs/.xlog$bnum");
if (-f "$changelog.bak") {
	open(OLOG, "$changelog.bak") ||
		die "$progname: can't open $changelog.bak: $!\n";
	print LOG while <OLOG>;
	close OLOG;
}
close LOG;

print "$progname: checking in $changelog and computing diff...\n";

# It is safe to run a patcil and a patdiff now, since the Changelog file has
# been updated anyway: any log done while checking that file in will not
# appear in the patch log nor the Changelog.

system 'perl', '-S', 'patcil', '-p', $changelog;
system 'perl', '-S', 'patdiff', $changelog;

exit 0;		# All done.

# Returns true if .clog and .rlog (it it exists) are newer than .xlog.
sub newertmp {
	return 1 unless -f ".xlog$bnum";	# To force regeneration
	return 1 if &newer(".clog$bnum", ".xlog$bnum") ||
		(!$changercs || &newer(".rlog$bnum", ".xlog$bnum"));
	0;
}

# Returns true if $file is newer than the reference file $ref.
sub newer {
	local($file, $ref) = @_;
	(stat($file))[9] >= (stat($ref))[9];
}

# Retursn true if $file is up-to-date with respect to .logs and .mods.
sub uptodate {
	local($file) = @_;
	return 0 unless -f $file;	# Cannot be up-to-date if missing
	&newer($file, ".logs$bnum") && &newer($file, ".mods$bnum");
}

# Add file to the LOG descriptor, skipping the first three lines of that file.
sub addlog {
	local($file) = @_;
	open(FILE, $file) || die "$progname: can't reopen $file: $!\n";
	$_ = <FILE>; $_ = <FILE>; $_ = <FILE>;
	print LOG while <FILE>;
	close FILE;
}

# Build RCS logs, for each file listed in the %fileseen array, into %rcslog.
# Common RCS log messages are grouped under the same entry.
sub buildlogs {
	local($log);
	local(@files);
	local($first);
	local(%invertedlog);
	foreach $file (keys %fileseen) {
		$log = &rcslog($file);
		next if $log eq '';
		$invertedlog{$log} .= "$file ";
	}
	foreach $log (keys %invertedlog) {
		@files = split(' ', $invertedlog{$log});
		$first = (sort @files)[0];
		$rcslog{$first} = join(', ', @files) . ': ' . $log;
	}
}

# Grab log for a given file by parsing its $Log section. Only comments
# relevant to the patch are kept. This relies on the presence of the patchxx:
# leading string in front of each comment.
# If not sufficient (because people don't use patchxx prefixes), then we'll
# need a more sophisticated algorithm parsing revisions lines to see where we
# left of at the last patch.
sub rcslog {
	local($file) = @_;
	open(FILE, "../$file") || warn "$me: can't open $file: $!\n";
	local($_);
	local($comment, $len);
	local($pcomment) = "patch$bnum:";
	local($plen) = length($pcomment);
	local($c);
	local($lastnl) = 1;
	local($kept);			# Relevant part of the RCS comment which is kept
	file: while (<FILE>) {
		if (/^(.*)\$Log[:\$]/) {
			$comment = $1;
			$comment =~ s/\s+$//;	# Newer RCS chop spaces on emtpy lines
			$len = length($comment);
			while (<FILE>) {
				$c = substr($_, 0, $len);
				last file unless $c eq $comment;
				$_ = substr($_, $len, 9_999);
				if ($lastnl) {
					last file unless /^\s*Revision\s+\d/;
					$lastnl = 0;
				} elsif (/^\s*$/) {
					$lastnl = 1;
				} else {
					s/^\s*//;	# Older RCS will have space here
					$c = substr($_, 0, $plen);
					last file unless $c eq $pcomment;
					# Comment for that patch is kept after space cleanup
					$_ = substr($_, $plen, 9_999);
					s/^\s*//;
					s/\s*$//;
					$_ .= '.' unless /\.$/;
					s/^(.)/\U$1/;	# Ensure upper-cased to start sentence
					s/^/  / if $kept;
					$kept .= $_;	# Will be reformatted later on
				}
			}
		}
	}
	close FILE;
	$kept;
}

# Format line to fit in 80 columns (70 + 8 for the added leading tabs).
# Rudimentary parsing to break lines after a , or a space.
sub format {
	local($_) = @_;
	local($tmp);
	local($msg);
	while (length($_) > 70) {
		$tmp = substr($_, 0, 70);
		$tmp =~ s/^(.*)([,\s]).*/$1/;
		$msg .= "\t$tmp" . ($2 eq ',' ? ',' : '') . "\n";
		$_ = substr($_, length($tmp), 9_999);
		$_ =~ s/^\s+//;
	}
	$msg .= "\t$_\n";
	$msg;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-hnruV]
  -h : print this message and exit.
  -n : not-really mode: force re-edit, but stop after updating.
  -r : reuse existing change file candidate entries (supersedes -u).
  -u : update mode, recreate files only when out of date.
  -V : print version number and exit.
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>patlog
$grep -v '^;#' ../pl/tilde.pl >>patlog
$grep -v '^;#' ../pl/profile.pl >>patlog
chmod +x patlog
$eunicefix patlog

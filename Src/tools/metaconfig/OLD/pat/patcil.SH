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
echo "Extracting pat/patcil (with variable substitutions)"
$cat >patcil <<!GROK!THIS!
$startperl
	eval "exec perl -i~ -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patcil.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.4  1994/10/29  16:42:12  ram
# patch36: now honors the VISUAL and EDITOR environment variables
# patch36: newer RCS programs chop trailing spaces in log messages
# patch36: separated V/E and v/e commands
# patch36: new 'v' command to edit the file being patcil'ed
# patch36: added hook for 'V' command (not implemented yet)
#
# Revision 3.0.1.3  1994/01/24  14:30:04  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/25  14:05:35  ram
# patch6: moved geteditor to ../pl/editor.pl
#
# Revision 3.0.1.1  1993/08/19  06:42:33  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:40  ram
# Baseline for dist 3.0 netwide release.
#

\$defeditor = '$defeditor';
\$pager = '$pager';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patcil <<'!NO!SUBS!'

$progname = &profile;			# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("abfhnpqsV");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$RCSEXT = ',v' unless $RCSEXT;
$PAGER = $ENV{'PAGER'} || "$pager";
$EDITOR = &geteditor;

system 'mkdir', 'RCS' unless -d 'RCS';

chop($pwd = `pwd`) unless -f '.package';
until (-f '.package') {
	die "$progname: no .package file!  Run packinit.\n" unless $pwd;
	chdir '..' || die "Can't cd ..";
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

system 'mkdir', 'bugs' unless -d 'bugs';
open(LOGS,">>bugs/.logs$bnum");		# Remember logs for patmake
open(MODS,">>bugs/.mods$bnum");		# Remember modified files

push(@sw,'-q') if $opt_q;
push(@sw,'-f') if $opt_f;

if ($opt_a) {
	open(MANI,"MANIFEST.new") || die "$progname: can't read MANIFEST.new: $!\n";
	@ARGV = ();
	while (<MANI>) {
	    chop;
		s|^\./||;
		next if m|^patchlevel.h|;		# Special file
		($_) = split(' ');
		next if -d;
	    push(@ARGV,$_);
	}
	close MANI;
} elsif ($opt_n) {
	&newer;
}

@filelist = @ARGV;

sub CLEANUP {
	print "$progname: Warning: restore $ARGV\n";
	exit 1;
}

if ($opt_s) {
	open(TTY,">/dev/tty");
	select(TTY);
	$| = 1;
	select(stdout);
	$SIG{'INT'} = 'CLEANUP';
	while (<>) {
		if (/^(.*)\$Log[:\$]/) {
			$comment = $1;
			$comment =~ s/\s+$//;	# Newer RCS chop spaces on emtpy lines
			$len = length($comment);
			print;
			$lastnl = 1;
			logline: while (<>) {
				$c = substr($_,0,$len);
				last logline unless $c eq $comment;
				$_ = substr($_,$len,999);
				if ($lastnl) {
					unless (/^\s*Revision\s+\d/) {
						$_ = $comment . $_;
						last logline;
					}
					$lastnl = 0;
				} else {
					$lastnl = 1 if /^\s*$/;
				}
			}
		}
	}
	continue {
		print;
		if ($ARGV ne $oldargv) {
			print TTY "$progname: stripping $ARGV...\n";
			$oldargv = $ARGV;
		}
	}
	$SIG{'INT'} = 'DEFAULT';
	close TTY;
}

if ($opt_b) {
	$flist = &rcsargs(@filelist);
	@flist=split(' ',$flist);
	system 'rcs', '-u', @flist;
	system 'rcs', "-l$revbranch", @flist;
	system 'ci', '-l', "-r$revbranch", @sw, @flist;
	exit 0;
}

open(MANI,"MANIFEST.new") || die "$progname: can't open MANIFEST.new: $!\n";
while (<MANI>) {
	# Find how many spaces the user wants before comments
	$space || /(\S+\s+)\S+/ && ($space = length($1));
	($file,$file_comment) = m|(\S+)\s+(.*)|;
	$inmani{$file} = 1;						# File is listed in MANIFEST
	$comment{$file} = $file_comment;		# Save comments
}
close MANI;
$space = 29 unless $space;		# Default value

file: foreach $file (@filelist) {
	$files = &rcsargs($file);
	@files = split(' ',$files);
	$file = $files[1] if $file =~ /\.$RCSEXT$/;
	unless ($inmani{$file}) {
		print "$file does not appear to be in your MANIFEST.new--add? [y] ";
		$ans = <stdin>;
		if ($ans !~ /^n/i) {
			print "MANIFEST.new comment? ";
			$file_comment = <stdin>;
			chop($file_comment);
			$spacenum = $space - length($file);
			$blank = " ";
			$blank = " " x $spacenum unless $spacenum < 1;
			`echo '${file}${blank}$file_comment' >>MANIFEST.new`;
			if (-f 'MANIFEST') {
				print "(Also adding file to your MANIFEST)\n";
				# Add a (new) at the end, so the two manifests will
				# differ and thus manifest will get patched correctly.
				`echo '${file}${blank}$file_comment (new)' >>MANIFEST`;
				print MODS "MANIFEST\n";
			}
		} else {
			$file_comment = "";			# No file, no comment
		}
	}
	$is_first = 0;			# Suppose this is not the first cil
	$revs = 0;				# Makes revs a numeric variable
	$rlog = `rlog -r$baserev -r$revbranch $files 2>&1`;
	($total) = ($rlog =~ /total revisions: (\d+)/);
	($revs) = ($rlog =~ /selected revisions: (\d+)/);
	$comment = &rcscomment($file);
	if (!$revs) {
		if ($total) {
			if ($rlog !~ /locks:\s*;/) {
				system 'rcs', '-u', @files;	# unlock branch
			}
			# New trunck revision
			system 'rcs', '-l', @files;		# lock trunk
		}
		else {
			$file_comment = $comment{$file} if $inmani{$file};
			if ($comment ne '') {
				&feed($file_comment, 'rcs', '-i', "-c$comment", @files);
			} else {
				&feed($file_comment, 'rcs', '-i', @files);
			}
		}
		if ($opt_p) {		# check in null as trunk revision
			rename($file, "$file.xxx");
			`cp /dev/null $file` unless -f $file;
			&cil_col("empty\n", $baserev);
			system 'rcs', "-Nlastpat:$baserev", @files;
			rename("$file.xxx", $file);
			$mess = &getlog($file);
			next file if $mess eq 'nope';
			system 'rcs', '-u', @files;		# Unlock trunck
			&feed($mess, 'ci', "-l$revbranch", @sw, @files) unless $?;
		} else {
			$is_first = 1;			# This is the first cil
			$mess = &getlog($file);
			next file if $mess eq 'nope';
			&cil_col($mess, $baserev);
			system 'rcs', "-Nlastpat:$baserev", @files;
		}
	} else {
		if (!$opt_f) {
			if ($revs == 1) {
				$delta = `rcsdiff -r$baserev $files 2>/dev/null`;
			} else {
				$delta = `rcsdiff -r$revbranch $files 2>/dev/null`;
			}
			if ($delta eq '') {		# No change in file
				print "$progname: no changes in $file since last patcil.\n";
				next;				# Skip file
			}
		}
		if ($revs == 1) {
			$mess = &getlog($file);
			next file if $mess eq 'nope';
			&cil_cil($mess, $revbranch);
		} else {
			$mess = &getlog($file);
			next file if $mess eq 'nope';
			&cil_col($mess, $revbranch);
		}
	}
}

# Used for the first revisions on a branch
sub cil_cil {
	local($mess) = shift(@_);
	local($rev) = shift(@_);
	if (&feed($mess, 'ci', @sw, "-l$rev", @files)) {
		print "$progname: unlocking and trying again...\n";
		system 'rcs', '-u', @files;
		&feed($mess, 'ci', @sw, "-l$rev", @files) unless $?;
	}
}

# Run a ci -l on the file. If this fails, try to lock the file first.
# If this fails again, try again with a separate checkout.
sub cil_col {
	local($mess) = shift(@_);
	local($rev) = shift(@_);
	if (&feed($mess, 'ci', @sw, "-l$rev", @files)) {
		print "$progname: locking and trying again...\n";
		if ($rev =~ /\d+\.\d+\.\d+/) {
			system 'rcs', "-l$rev", @files;		# Lock branch
		} else {
			system 'rcs', '-l', @files;			# Lock trunck
		}
		if (&feed($mess, 'ci', @sw, "-l$rev", @files)) {
			print "$progname: trying again with separate checkout...\n";
			if (&feed($mess, 'ci', @sw, "-r$rev", @files)) {
				system 'rcs', "-u$rev", @files unless $?;
				system 'co', "-l$rev", @files unless $?;
			} else {
				print "$progname: sorry, giving up...\n";
			}
		}
	}
}

sub feed {
	local($mess) = shift(@_);
	open(FORK,"|-") || exec @_;
	print FORK $mess;
	close FORK;
	$?;
}

sub getlog {
	local($file) = @_;
	local($mess) = '';
	local($prefix) = "patch$bnum: ";
	local($prompt) = $comment;
	local($len);
	$prompt = '>> ' unless $prompt;
	$prefix = '' if $is_first;
	print "Type log message for $file (finish with ., CR for previous):\n";
	try: for (;;) {
		line: for (print "$prompt$prefix";;print "$prompt$prefix") {
			if ($always) {
				print "\n";
				$line = '';
			} else {
				$line = <stdin>;
			}
			if ($line =~ /^\.?$/) {
				if ($mess) {
					last line;
				} else {
					$line = 'p';
				}
			}
			if ($line =~ /^[h?]$/) {
				print "
CR or .	Terminate log message.
!<cmd>	Start command in a subshell.
D	Print out diff listing since last patch.
N	Give name of the current file.
E	Call editor for log message with a diff listing.
V	Call editor for file with a context diff added to HISTORY.
X	Extract HISTORY and append it to current log message.
a	Always use this message.
d	Print out diff listing since last patcil.
f	Forget message I have so far.
h or ?	This help message.
l	List what I have so far.
n	Forget this file; go to next file if any.
p	Append previous message.
r	Print out the rlog for this file.
e	Call editor for log message.
v	Call editor for file.
x	Toggle patch# prefix.

";
				next line;
			}
			if ($line =~ /^!(.*)$/) {
				$_ = $1;
				$_ = ($ENV{'SHELL'} || "/bin/sh") if $1 eq '';
				system $_;
				next line;
			}
			if ($line =~ /^E$/) {
				$mess .= "\n" . `rcsdiff -c -rlastpat $files`;
			}
			if ($line =~ /^e$/) {
				$mess = &edit($mess);
				next line;
			}
			if ($line =~ /^V$/) {
				######## FIXME #########
				# Will do something like:
				# &add_history($file, `rcsdiff -c -rlastpat $files`);
				# HISTORY
				# Extract or add this. Create it if not already there.
				# $Log
				# $EndLog  <<-- stops HISTORY and COPYRIGHT lookup
				########################
				print "HISTORY processing not implemented yet.\n";
				print "(You have to use 'E' to get old 'V' processing).\n";
				next line;
			}
			if ($line =~ /^v$/) {
				system $EDITOR, $file;
				next line;
			}
			if ($line =~ /^r$/) {
				system "rlog $files | $PAGER";
				next line;
			}
			if ($line =~ /^D$/) {
				if ($revs == 0) {
					print "Sorry. There is no revision for this file yet.\n";
				} else {
					system "rcsdiff -c -rlastpat $files | $PAGER";
				}
				next line;
			}
			if ($line =~ /^d$/) {
				if ($revs == 0) {
					print "Sorry. There is no revision for this file yet.\n";
				}
				elsif ($revs == 1) {
					system "rcsdiff -c -r$baserev $files | $PAGER";
				} else {
					system "rcsdiff -c -r$revbranch $files | $PAGER";
				}
				next line;
			}
			if ($line =~ /^N$/) {
				print "Typing log message for $file.\n";
				next line;
			}
			if ($line =~ /^f$/) {
				$mess = '';
				next line;
			}
			if ($line =~ /^a$/) {
				$always++ if $mess || $prevmess;
				next line;
			}
			if ($line =~ /^n$/) {
				$mess = 'nope';
				last line;
			}
			if ($line =~ /^l$/) {
				foreach $line (split(/\n/,$mess)) {
					print $prompt,$line,"\n";
				}
				next line;
			}
			if ($line =~ /^p$/) {
				$mess .= $prevmess;
				foreach $line (split(/\n/,$prevmess)) {
					print $prompt,$line,"\n";
				}
				next line;
			}
			if ($line =~ /^X$/) {
				foreach $line (split(/\n/, &xtract_history($file))) {
					$mess .= $prompt . $line . "\n";
					print $prompt,$line,"\n";
				}
				next line;
			}
			if ($line =~ /^x$/) {
				$prefix = $prefix ? '' : "patch$bnum: ";
				next line;
			}
			$mess .= $prefix . $line;
			$len = length($comment . $prefix . $line);
			if ($len > 80) {
				print "(Warning: last line longer than 80 chars)\n";
			} elsif ($len > 72) {		# In case of vi with line numbers
				print "(Warning: last line longer than 72 chars)\n";
			}
			if (length($mess) > 511) {
				print "You'll have to trim to less than 512 chars...\n";
				sleep(3);
				$mess = &edit($mess);
			}
		}
		$mess = $prevmess if $mess eq '';
		if (!$mess) {
			print "No previous message, try again.\n";
			next try;
		}
		if (length($mess) > 511) {
			print "Sorry, that's too long; RCS won't take it.  Try again...\n";
			next try;
		}
		last try;
	}
	unless ($is_first) {
		print LOGS $mess unless $mess eq 'nope';
		print MODS "$file\n";
	}
	$prevmess = $mess unless $mess eq 'nope';
	$mess;			# Returned value
}

sub edit {
	local($text) = join("\n", @_);
	open(TMP,">/tmp/cil$$") || die "Can't create /tmp/cil$$";
	print TMP $text;
	close TMP;
	system $EDITOR, "/tmp/cil$$";
	$text = `cat /tmp/cil$$`;
	unlink "/tmp/cil$$";
	$text;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-abfhnpqsV] [filelist]
  -a : all the files in MANIFEST.new
  -b : batch mode
  -f : force check in (passed through to ci)
  -h : print this message and exit
  -n : all the files newer than patchlevel.h
  -p : patching mode (null trunk revision if new file)
  -q : ask rcs to be quiet
  -s : strip log messages
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/newer.pl >>patcil
$grep -v '^;#' ../pl/package.pl >>patcil
$grep -v '^;#' ../pl/rcsargs.pl >>patcil
$grep -v '^;#' ../pl/comment.pl >>patcil
$grep -v '^;#' ../pl/editor.pl >>patcil
$grep -v '^;#' ../pl/tilde.pl >>patcil
$grep -v '^;#' ../pl/profile.pl >>patcil
chmod +x patcil
$eunicefix patcil

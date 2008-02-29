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
echo "Extracting bin/packinit (with variable substitutions)"
cat >packinit <<!GROK!THIS!
# feed this into perl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: packinit.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.4  1997/02/28  14:55:14  ram
# patch61: fixed one wrong ':' comment in .package
#
# Revision 3.0.1.3  1994/10/29  15:43:49  ram
# patch36: added support for user-defined C and shell file extensions
# patch36: now asks whether a ChangeLog file is to be managed
#
# Revision 3.0.1.2  1994/01/24  13:54:07  ram
# patch16: can now configure mailing list knowledge from packinit
#
# Revision 3.0.1.1  1993/08/19  06:41:53  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:05  ram
# Baseline for dist 3.0 netwide release.
#

\$orgname='$orgname';
\$myhostname='$myhostname';
\$mydomain='$mydomain';
\$nametype='$nametype';
!GROK!THIS!
cat >>packinit <<'!NO!SUBS!'

print <<EOM;

This program designates the current directory as the top level directory
of a package on which you want to use the programs metaconfig, makedist,
or the patch generation programs.  It will not damage the current directory
in any way except to create a .package file.

EOM

$mypackver = 3.036;		# Base revision number plus patchlevel

if (-f '.package') {
	&readpackage;
	if ($packver > $mypackver) {
		die "This .package file was produced by a newer packinit than I am.\n".
		"Please find a packinit of version $packver or greater.\n";
	}
} elsif (-f '../.package' || -f '../../.package' || -f '../../../.package') {
	die "Run in top level directory only.\n";
}

# Now set up to do reads with possible shell escape.
sub myread {
	($rp,$dflt) = @_;
	$rp .= " [$dflt]";
	print "$rp ";
	$ans='!';
	while ($ans =~ /^!/) {
		$ans = <STDIN>;
		chop($ans);
		if ($ans eq '!') {
			system '/bin/sh';
			print "\n$rp ";
		} elsif ($ans =~ s/^!//) {
			system '/bin/sh', '-c', $ans;
			print "\n$rp ";
		}
	}
	$ans = $dflt if $ans eq '';
	$ans = '' if $ans eq 'none';
	$ans;
}

$dflt = $package;
($dflt) = (`pwd | tr "[A-Z]" "[a-z]"` =~ m|.*/(.*)|) unless $package;

print <<EOM;
Your package will be known by some name, which should be a single word.
Generally it is the name of the chief executable program.

EOM
$package = &myread('What is the name of your package?',$dflt);

if ($baserev ne '') {
	$dflt=$baserev;
} else {
	print "\n";
	$dflt='';
	print "Checking RCS files for current version...";
	@rcs = <RCS/*,v *,v>;
	$rcs = shift(@rcs);
	if (! -f $rcs) {
		$rcs = shift(@rcs);
		if (! -f $1) {
			print "I don't see any RCS files there (yet).";
			$dflt='1.1';
		}
	}
	$revs=0;
	if ($dflt eq '') {
		$rlog = `rlog $rcs`;
		($dflt) = ($rlog =~ /\nhead:\s*(\d+\.\d+)/);
		$rlog = `rlog -r$dflt.1- -r$dflt.2- -r$dflt.3- -r$dflt.4- $rcs`;
		($revs) = ($rlog =~ /selected revisions:\s*([\d.]+)/);
		$dflt='1.1' if $dflt eq '';
	}

	print <<EOM;

To use the patch generating portion of the system, you must have RCS.  You
must begin with a freshly checked-in trunk revision (n.n) and choose a branch
number for patches.  The trunk revision upon which the patch branch is based
is called the base revision.

EOM

	if ($revs > 1) {
		print <<EOM;
(The current revision ($dflt) has branches--you may have to check in a new
trunk revision, or use patbase to mark the base revisions.)
EOM
		($first,$second) = split(/\./,$dflt);
		++$second;
		$dflt="$first.$second";
	}
}

print "\n";
$foo = &myread('What is or will be the base revision number?', $dflt);
if ($baserev ne $foo) {
	$baserev = $foo;
	$ftpdir = '';		# invalidate ftp directory on version change
}

print "\n";
$dflt = ($patchbranch ne '' ? $patchbranch : 1);
$patchbranch =
	&myread('What branch number do you want to use for patches?', $dflt);

$dflt = $cext eq '' ? 'none' : $cext;
print <<EOM;

Metaconfig will lookup for files listed in MANIFEST.new to scan for
known symbols. If you have non-standard extensions containing some
C symbols, you may wish to list them there, separating them with white
spaces and using shell regular expressions, such as '.xs .p .t' to let
metaconfig know about them. Say "none" for none.

EOM
$cext = &myread('Additional file extensions to identify C files?', $dflt);
$cext = '' if $cext eq 'none';

$dflt = $shext eq '' ? 'none' : $shext;
print <<EOM;

Likewise, metaconfig needs to know about the files containing at least
some shell symbols. Automatic symbol substitution will be performed on
the .SH files only, but you may want metaconfig to scan other files as
well, provided you ensure proper variable substitutions by your own
means. Please add extensions using shell-style regexps. Say "none" if
no specific file extensions are used.

EOM
$shext = &myread('Additional file extensions to identify SH files?', $dflt);
$shext = '' if $shext eq 'none';

$dflt = $copyright eq ' ' ? 'n' : 'y';
print <<'EOM';

If you wish, you may use a generic copyright. This is appropriate if all
your source file have to be distributed under the same conditions. Using
this facility means you will not be able to change the copyright notice
between patches (i.e. while in the same version number). All you need to
do is write a copyright file containing the proper copyright notice, and
then use @COPYRIGHT@ within your source code (before any RCS marker). That
will be extended to the full copyright, preserving any leading comment.

EOM
$use_copyright = &myread('Do you wish to use a generic copyright?', $dflt);
if ($use_copyright =~ /^y/i) {
	print "\n";
	$copyright = '' if $copyright eq ' ';	# They changed their mind!
	$dflt = $copyright || 'COPYRIGHT';
	$copyright = &myread('What file do you wish to store it in?', $dflt);
} else {
	$copyright = ' ';		# Remember they don't want it
}

if ($use_copyright =~ /^y/i) {
	$ans = 'yes';			# Yes, use our own diff (have to expand copyright)
} else {
	print "\n";
	$dflt = ($mydiff eq '' ? 'n' : 'y');
	$ans = &myread(
	'Do you want to use your own diff (rather than rcsdiff -c) for patches?',
		$dflt);
}
if ($ans =~ /^n/i) {
	$mydiff='';
} else {
	print "\n";
	$dflt = $mydiff || 'diff -c';
	$mydiff = &myread('What diff command do you want to use?', $dflt);
}

$dflt = $changelog eq ' ' ? 'n' : 'y';
print <<'EOM';

I can set up things so that a ChangeLog file is maintained automatically.
This file will contain the description which is filled in into every issued
patches, and optionally, the list of RCS logs for each modified file. The
ChangeLog file is sorted in reverse order of issued patches, i.e. the most
recent changes are at the top of the file.

EOM
$use_changelog = &myread('Do you wish me to maintain a ChangeLog file?', $dflt);
if ($use_changelog =~ /^y/i) {
	print "\n";
	$changelog = '' if $changelog eq ' ';	# They changed their mind!
	$dflt = $changelog || 'ChangeLog';
	$changelog = &myread('What file do you wish to store changes in?', $dflt);
	$dflt = $changercs ? 'y' : 'n';
	print "\n";
	$ans = &myread('Do you wish to include RCS logs as well?', $dflt);
	$changercs = $ans =~ /^y/i;
} else {
	$changelog = ' ';		# Remember they don't want it
	$changercs = 0;
}

print <<EOM;

Over the lifetime of the $package package, people will want to request
distribution kits and patches.  In particular, automatically generated
patches will say where to get previous patches from.

EOM
$logname = &getlogname;
$dflt = $maintname || &getfullname($logname);
$maintname = &myread('Who should requests be sent to (full name)?', $dflt);

print <<EOM;

Now you need to give a one-line network mailing address for $maintname.
It does not need to be parseable by machine, but can be of the form:

	{name1,name2,name3}!myhost!myname

	or

	myname\@myhost.domain

EOM
$dflt = $maintloc || "$logname\@$myhostname$mydomain";
$maintloc = &myread('What is the network mailing address?', $dflt);

print "\n";
$dflt = $ftpsite ? 'y' : 'n';
$ans = &myread(
	'Will you put patches where they can be acquired by anonymous FTP?',$dflt);
if ($ans =~ /^n/i) {
	$ftpsite='';
} else {
	print "\n";
	$dflt = $ftpsite;
	($dflt = $maintloc) =~ s/.*@([^\s,()]*).*/$1/ unless $dflt;
	$ftpsite = &myread('What is the Internet sitename for that?',$dflt);
}

print <<EOM;

If you have mailagent installed (posted in comp.sources.misc), you may choose
to distribute patches via e-mail and have all the issued patches mention
this, as well as instructions telling how to get those (missing) patches.

EOM
$dflt = $mailagent eq 'true' ? 'y' : 'n';
$mailagent = &myread(
	'Do you wish to let people retrieve patches via mailagent?', $dflt);
$mailagent = ($mailagent =~ /^y/i) ? 'true' : 'false';

print "\n";
$dflt = $list_users eq 'true' ? 'y' : 'n';
$list_users = &myread(
	"Do you have a mailing list set up for $package users?", $dflt);
$list_users = ($list_users =~ /^y/i) ? 'true' : 'false';

if ($list_users eq 'true') {
	print "\n";
	$dflt = $list_name || "$package-users";
	$list_name = &myread('How is the mailing list named?', $dflt);

	print <<EOM;

The $list_name mailing list is now to be defined in terms of e-mail
addresses where users can send messages to the whole list (that's the
mailing list address) or send administrative requests to subscribe or
unsubscribe among other things (that's the administrative mailing
address). Usually, this last address will turn out to be that of a
mailing list manager program like majordomo or listserv.

EOM
	$dflt = $list_addr || "$list_name\@$myhostname$mydomain";
	$list_addr = &myread('What is Internet mailing list address?', $dflt);

	print "\n";
	($list_domain) = $list_addr =~ /^[\w-]+\@(.*)/;
	$list_domain = "$myhostname$mydomain" unless $list_domain;
	$dflt = $list_request || "$list_name-request\@$list_domain";
	$list_request = &myread('What is administrative mailing address?', $dflt);

	%mlm = (
		'majordomo',
			"subscribe $list_name \$cf_email;unsubscribe $list_name \$cf_email",
		'listserv',
			"SUBSCRIBE $package \$cf_name;UNSUBSCRIBE $package",
		'human',
			"subscribe $list_name \$cf_email;unsubscribe $list_name \$cf_email",
	);
	
	print "\n";
	($dflt) = $list_request =~ /^([\w-]+)\@/;
	$dflt =~ tr/A-Z/a-z/;
	$list_cmds = $mlm{$dflt};
	$dflt = 'human' if $list_cmds eq '';
	$old_list_manager = $list_manager;
	$list_manager = &myread(
		'What type of mailing list manager are you using?', $dflt);
	$list_manager =~ tr/A-Z/a-z/;
	$list_sub = $list_unsub = '' if $old_list_manager ne $list_manager;
	
	$list_cmds = $mlm{$list_manager};
	$list_cmds = $mlm{'human'} if $list_cmds eq '';
	@list_cmds = split(/;/, $list_cmds);

	print <<'EOM';

In the next two questions, you may use the following variables in your
answers:

	$cf_email           e-mail address of the user
	$cf_name            full name of the user

Those variables will be set by Configure prior sending the requests to
the administrative mailing list address.

EOM
	$dflt = $list_sub || $list_cmds[0];
	$list_sub = &myread('Subscribe command?', $dflt);
	print "\n";
	$dflt = $list_unsub || $list_cmds[1];
	$list_unsub = &myread('Unsubscribe command?', $dflt);
}

print "\n";
$dflt = $orgname || $ENV{'ORGANIZATION'};
$orgname = &myread('Organization:',$dflt);
$orgname = &tilda_expand($orgname);		# Can specify filename with ~user

print "\n";
$dflt = $newsgroups || 'comp.sources.bugs';
$newsgroups = &myread('Newsgroup(s) to post patches to:', $dflt);

print "\n";
$dflt = $recipients || 'source-archives@mirror.TMC.COM';
$recipients = &myread('Recipient(s) to send patches to:',$dflt);

if ($ftpsite) {
	print "\n";
	$dflt = $ftpdir || "/usr/spool/ftp/pub/$package.$baserev/patches";
	$ftpdir = &myread('FTP directory to copy patches to:',$dflt);
} else {
	$ftpdir = '';
}

print "\nCreating .package...\n";
open(PACKAGE, '>.package') || die "Can't create .package";
chop($date = `date`);
print PACKAGE <<EOF;
: This file was created by running packinit on $date.
: Do not hand edit -- run packinit again if changes are to be made.
packver='$mypackver'
: Basic variables
package=$package
baserev=$baserev
patchbranch=$patchbranch
copyright='$copyright'
mydiff='$mydiff'
maintname='$maintname'
maintloc='$maintloc'
ftpsite='$ftpsite'
orgname='$orgname'
newsgroups='$newsgroups'
recipients='$recipients'
ftpdir='$ftpdir'
mailagent='$mailagent'
changelog='$changelog'
changercs=$changercs
: File lookup extensions
cext='$cext'
shext='$shext'
: Mailing list variables
list_users='$list_users'
list_name='$list_name'
list_addr='$list_addr'
list_request='$list_request'
list_manager='$list_manager'
list_sub='$list_sub'
list_unsub='$list_unsub'
: Derivative variables -- do not change
revbranch=\"\$baserev.\$patchbranch\"
EOF

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>packinit
$grep -v '^;#' ../pl/logname.pl >>packinit
$grep -v '^;#' ../pl/fullname.pl >>packinit
$grep -v '^;#' ../pl/tilde.pl >>packinit
chmod 755 packinit
$eunicefix packinit

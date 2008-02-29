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
echo "Extracting mcon/mconfig (with variable substitutions)"
cat >mconfig <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: mconfig.SH 78389 2004-11-30 00:17:17Z manus $
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
# Key Contributor: Harlan Stenn <harlan@mumps.pfcs.com>
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.5  1995/07/25  14:19:05  ram
# patch56: new -G option
#
# Revision 3.0.1.4  1994/06/20  07:11:04  ram
# patch30: new -L option to override public library path for testing
#
# Revision 3.0.1.3  1994/01/24  14:20:53  ram
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/10/16  13:53:10  ram
# patch12: new -M option for magic symbols and confmagic.h production
#
# Revision 3.0.1.1  1993/08/19  06:42:26  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:17  ram
# Baseline for dist 3.0 netwide release.
#

# Perload ON

\$MC = '$privlib';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
\$grep = '$grep';
!GROK!THIS!

$spitshell >>mconfig <<'!NO!SUBS!'
chop($date = `date`);
&profile;						# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("dhkmostvwGMVL:");

$MC = $opt_L if $opt_L;			# May override public library path
$MC = &tilda_expand($MC);		# ~name expansion
chop($WD = `pwd`);				# Working directory
chdir $MC || die "Can't chdir to $MC: $!\n";
chop($MC = `pwd`);				# Real metaconfig lib path (no symbolic links)
chdir $WD || die "Can't chdir back to $WD: $!\n";

++$opt_k if $opt_d;
++$opt_M if -f 'confmagic.h';	# Force -M if confmagic.h already there

if ($opt_V) {
	print STDERR "metaconfig $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

unlink 'Wanted' unless $opt_w;			# Wanted rebuilt if no -w
unlink 'Obsolete' unless $opt_w;		# Obsolete file rebuilt if no -w
&readpackage;							# Merely get the package's name
&init;									# Various initializations
`mkdir .MT 2>&1` unless -d '.MT';		# For private temporary files

&locate_units;				# Fill in @ARGV with a unit list
&extract_dependencies;		# Extract dependencies from units
&extract_filenames;			# Extract files to be scanned for
&build_wanted;				# Build a list of wanted symbols in file Wanted
&build_makefile;			# To do the transitive closure of dependencies
&solve_dependencies;		# Now run the makefile to close dependency graph
&create_configure;			# Create the Configure script and related files
&cosmetic_update;			# Update the manifests

if ($opt_k) {
	print "Leaving subdirectory .MT unremoved so you can peruse it.\n"
		unless $opt_s;
} else {
	`rm -rf .MT 2>&1`;
}
print "Done.\n" unless $opt_s;

# General initializations
sub init {
	&init_except;			# Token which have upper-cased letters
	&init_keep;				# The keep status for built-in interpreter
	&init_priority;			# Priorities for diadic operators
	&init_constants;		# Define global constants
	&init_depend;			# The %Depend array records control line handling
}

sub init_constants {
	$NEWMANI = 'MANIFEST.new';		# List of files to be scanned
	$MANI = 'MANIFEST';				# For manifake
}

# Record the exceptions -- all symbols but these are lower case
sub init_except {
	$Except{'Mcc'}++;
	$Except{'Author'}++;
	$Except{'Date'}++;
	$Except{'Header'}++;
	$Except{'Id'}++;
	$Except{'Locker'}++;
	$Except{'Log'}++;
	$Except{'RCSfile'}++;
	$Except{'Revision'}++;
	$Except{'Source'}++;
	$Except{'State'}++;
}

# Print out metaconfig's usage and exits
sub usage {
	print STDERR <<'EOH';
Usage: metaconfig [-dhkmostvwGMV] [-L dir]
  -d : debug mode.
  -h : print this help message and exits.
  -k : keep temporary directory.
  -m : assume lots of memory and swap space.
  -o : maps obsolete symbols on new ones.
  -s : silent mode.
  -t : trace symbols as they are found.
  -v : verbose mode.
  -w : trust Wanted file as being up-to-date.
  -G : also provide a GNU configure-like front end.
  -L : specify main units repository.
  -M : activate production of confmagic.h.
  -V : print version number and exits.
EOH
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' pl/locate.pl >>mconfig 
$grep -v '^;#' pl/common.pl >>mconfig 
$grep -v '^;#' pl/depend.pl >>mconfig 
$grep -v '^;#' pl/init.pl >>mconfig 
$grep -v '^;#' pl/extract.pl >>mconfig 
$grep -v '^;#' pl/files.pl >>mconfig 
$grep -v '^;#' pl/wanted.pl >>mconfig 
$grep -v '^;#' pl/obsolete.pl >>mconfig 
$grep -v '^;#' pl/makefile.pl >>mconfig 
$grep -v '^;#' pl/order.pl >>mconfig 
$grep -v '^;#' pl/configure.pl >>mconfig 
$grep -v '^;#' pl/cosmetic.pl >>mconfig 
$grep -v '^;#' pl/eval.pl >>mconfig 
$grep -v '^;#' ../pl/package.pl >>mconfig 
$grep -v '^;#' ../pl/manifake.pl >>mconfig 
$grep -v '^;#' ../pl/tilde.pl >>mconfig 
$grep -v '^;#' ../pl/profile.pl >>mconfig 
chmod +x mconfig
$eunicefix mconfig

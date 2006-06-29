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
echo "Extracting mcon/mxref (with variable substitutions)"
cat >mxref <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: mxref.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1997/02/28  16:30:49  ram
# patch61: new -L option to match metaconfig and metalint
#
# Revision 3.0.1.2  1994/01/24  14:21:04  ram
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/19  06:42:27  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:18  ram
# Baseline for dist 3.0 netwide release.
#

# Perload ON

\$MC = '$privlib';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
\$grep = '$grep';
!GROK!THIS!

$spitshell >>mxref <<'!NO!SUBS!'
&profile;						# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts("df:hkmsVL:");

chop($date = `date`);
chop($WD = `pwd`);				# Working directory
$MC = $opt_L if $opt_L;			# May override  library path
$MC = &tilda_expand($MC);		# ~name expansion
chdir $MC || die "Can't chdir to $MC: $!\n";
chop($MC = `pwd`);				# Real metaxref lib path (no symbolic links)
chdir $WD || die "Can't chdir back to $WD: $!\n";

if ($opt_V) {
	print STDERR "metaxref $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$NEWMANI = $opt_f || 'MANIFEST.new';

&init;									# Various initializations
`mkdir .MT 2>&1` unless -d '.MT';		# For private temporary files
unlink 'Obsolete';						# Obsolete file rebuilt

&locate_units;				# Fill in @ARGV with a unit list
&extract_dependencies;		# Extract dependencies from units
&extract_filenames;			# Get source files from MANIFEST.new
&build_xref;				# Parse files, build I.* output

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
	&init_depend;			# The %Depend array records control line handling
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

# Print out metaxref's usage and exits
sub usage {
	print STDERR <<EOM;
Usage: metaxref [-dhkmsV] [-f manifest] [-L dir]
  -d : debug mode.
  -f : use that file as manifest instead of MANIFEST.new.
  -h : print this help message and exits.
  -k : keep temporary directory.
  -m : assume lots of memory and swap space.
  -s : silent mode.
  -L : specify main units repository.
  -V : print version number and exits.
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' pl/locate.pl >>mxref 
$grep -v '^;#' pl/common.pl >>mxref 
$grep -v '^;#' pl/xref.pl >>mxref 
$grep -v '^;#' pl/files.pl >>mxref 
$grep -v '^;#' pl/init.pl >>mxref 
$grep -v '^;#' pl/extract.pl >>mxref 
$grep -v '^;#' pl/obsolete.pl >>mxref 
$grep -v '^;#' pl/xwant.pl >>mxref 
$grep -v '^;#' pl/gensym.pl >>mxref 
$grep -v '^;#' ../pl/manifake.pl >>mxref
$grep -v '^;#' ../pl/tilde.pl >>mxref
$grep -v '^;#' ../pl/profile.pl >>mxref
chmod +x mxref
$eunicefix mxref

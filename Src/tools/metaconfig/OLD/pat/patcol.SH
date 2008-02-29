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
echo "Extracting pat/patcol (with variable substitutions)"
cat >patcol <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: patcol.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1994/01/24  14:30:25  ram
# patch16: now prefix error messages with program's name
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.2  1993/08/24  12:16:30  ram
# patch3: new -S option for snapshot check-outs
#
# Revision 3.0.1.1  1993/08/19  06:42:34  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:42  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
cat >>patcol <<'!NO!SUBS!'

$progname = &profile;			# Read ~/.dist_profile
require 'getopts.pl';
&usage unless $#ARGV >= 0;
&usage unless &Getopts("acd:f:hnmsCRS:V");

if ($opt_V) {
	print STDERR "$progname $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$RCSEXT = ',v' unless $RCSEXT;
$NEWMANI = 'MANIFEST.new' unless $NEWMANI = $opt_f;

chop($pwd = `pwd`) unless -f '.package';
until (-f '.package') {
	die "$progname: no .package file!  Run packinit.\n" unless $pwd;
	chdir '..' || die "$progname: can't cd ..: $!";
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
undef $opt_C unless -f $copyright;
&copyright'init($copyright) if $opt_C;
&makedir($opt_d) if $opt_d;

undef $opt_c unless $opt_d;		# Disable -c if not -d
undef $opt_R unless $opt_d;		# Disable -R if not -d
push(@sw, '-q') if $opt_s;		# Let RCS work quietly

if ($opt_n) {
	&newer;				# Look for files newer than patchlevel.h
} elsif ($opt_a) {
	open(MANI, $NEWMANI) || die "No $NEWMANI found.\n";
	@ARGV = ();
	while (<MANI>) {
		s|^\./||;
		next if m|^patchlevel.h| && !$opt_d;	# This file is built by hand
		chop;
		($_) = split(' ');
		next if -d;
		push(@ARGV,$_);
	}
	close MANI;
} elsif ($opt_m) {
	open(MODS,"bugs/.mods$bnum") || die "$progname: no modification found.\n";
	@ARGV = ();
	while (<MODS>) {
		next if m|^patchlevel.h$|;		# This file is built by hand
		chop;
		($_) = split(' ');
		next if -d;
		push(@ARGV,$_);
	}
	close MODS;
} elsif ($opt_S) {
	&readsnapshot($opt_S);
	foreach $file (sort keys %Snap) {
		push(@ARGV, $file);
	}
}

# Now loop over each file specified, doing a 'co -l'
foreach $file (@ARGV) {
	if ($opt_c && -f $file) {
		&copy_file($file, $opt_d);
		next;
	}
	# Continue only if file does not exist or option -d was used.
	if (! -f $file || $opt_d) {
		$files = &rcsargs($file);
		@files = split(' ', $files);
		if ($opt_S && ($rev = $Snap{$file}) ne '') {	# Use snapshot file
			&col($rev);
			next;
		}
		$rlog = `rlog -rlastpat- $files 2>&1`;
		($revs) = ($rlog =~ /selected revisions: (\d+)/);
		if (!$revs) {
			if ($opt_d) {
				&copy_file($file, $opt_d);
			} else {
				print STDERR "$progname: $file has never been checked in\n";
			}
		} else {
			# Look whether there is a branch
			if ($revs == 1) {
				$rlog = `rlog -r$revbranch $files 2>&1`;
				($revs) = ($rlog =~ /selected revisions: (\d+)/);
				$revs++;	# add the base revision (trunk)
			}
			if ($revs == 1) {
				&col($baserev);
			} else {
				&col($revbranch);
			}
		}
			
	}
}

# Run co -l on @files, unlock file if it fails and retry.
# If '-d' option was used, we check out in the specified
# directory, after having made all the necessary directories
# in the path name (which should be relative to the top).
sub col {
	local($rev) = shift;	# Revision to be checked out.
	if (! $opt_d) {
		if (system 'co',  "-l$rev", @sw, @files) {
			print "$progname: unlocking and trying again...\n" unless $opt_s;
			system 'rcs', '-u', @sw, @files;
			system 'co', "-l$rev", @sw, @files unless $?;
		}
	} else {
		local($name) = $files[0];	# First element is file name
		$_ = $name;
		s|(.*)/.*|\1| && &makedir("$opt_d/$_");
		if ($opt_C) {
			&copyright'expand("co -p @sw -r$rev $files[1]", "$opt_d/$name");
		} else {
			system "co -p -r$rev @sw $files[1] > $opt_d/$name";
		}
		system 'perl', '-pi', '-e', 's|Lock[e]r:.*\$|\$|;', "$opt_d/$name"
			if $opt_R;
		# If RCS file has x bits set, add them on new file
		-x $files[1] && chmod(0755, "$opt_d/$name");
	}
}

# Copy file into directory, eventually performing copyright expansion...
sub copy_file {
	local($file, $dir) = @_;
	local($base) = $file =~ m|^(.*)/.*|;
	&makedir("$dir/$base");
	if ($opt_C) {
		&copyright'expand("cat $file", "$dir/$file");
	} else {
		system 'cp', "$file", "$dir/$file";
	}
	system 'perl', '-pi', '-e', 's|Lock[e]r:.*\$|\$|;', "$dir/$file" if $opt_R;
	-x $file && chmod(0755, "$dir/$file");
	print "$progname: $file has been copied\n" unless $opt_s;
}

sub usage {
	print STDERR <<EOM;
Usage: $progname [-achnmsCRV] [-d directory] [-f mani] [-S snap] [filelist]
  -a : all the files in MANIFEST.new (see also -f)
  -c : copy files if checked-out copy exists (only when -d)
  -d : check out (or copy) in the specified directory
  -f : use supplied file instead of MANIFEST.new
  -h : print this message and exit
  -n : all the files newer than patchlevel.h
  -m : all the modified files (which have been patciled)
  -s : silent mode
  -C : perform copyright expansion on checked out (or copied) file
  -R : strip out RCS \$Locker marker from checked-out file (only when -d)
  -S : use snapshot file to determine file list and RCS revisions
  -V : print version number and exit
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/newer.pl >>patcol
$grep -v '^;#' ../pl/package.pl >>patcol
$grep -v '^;#' ../pl/rcsargs.pl >>patcol
$grep -v '^;#' ../pl/copyright.pl >>patcol
$grep -v '^;#' ../pl/makedir.pl >>patcol
$grep -v '^;#' ../pl/snapshot.pl >>patcol
$grep -v '^;#' ../pl/tilde.pl >>patcol
$grep -v '^;#' ../pl/profile.pl >>patcol
chmod +x patcol
$eunicefix patcol

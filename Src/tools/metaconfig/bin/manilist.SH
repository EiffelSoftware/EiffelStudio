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
echo "Extracting bin/manilist (with variable substitutions)"
$spitshell >manilist <<!GROK!THIS!
$startperl
	eval 'exec perl -S \$0 "\$@"'
		if \$running_under_some_shell;

# $Id: manilist.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1994/10/29  15:42:42  ram
# patch36: fixed open precedence problem for perl5
#
# Revision 3.0.1.2  1994/01/24  13:52:33  ram
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/19  06:41:52  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:03  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$pl = '$PATCHLEVEL';
!GROK!THIS!
$spitshell >>manilist <<'!NO!SUBS!'

# This script scans the MANIFEST.new file and builds some reports.

# The output can be somewhat changed to produce other kind of reports.
# The format is specified with a leading set of activation character, followed
# by a ':', and then a set of formatting macros. The leading characters tell
# when a report line shall be issued:
#  a: all files (shortcut for 'ix')
#  A: all files but the excluded ones
#  f: report for files only
#  d: report for directories only
#  m: report for files/directories found in the MANIFEST.new
#  n: report for files/directories not found in the MANIFEST.new
#  i: included files are listed
#  x: excluded files are listed
# Then a set of macros introduced by %:
#  %c: the leading one character code defined as follows:
#  		. if the file is up to date (i.e. not newer than patchlevel.h)
#  		- if the file is present in the manifest but is missing
#  		> if the file has changed since last patch.
#  		+ if the file is not present in the manifest but exists
#  		o if the file is not listed but exists and is older than patchlevel.h
#       x if the file in manifest and exists but was excluded
#       ? if the file in manifest but was excluded and does not exist
#  %n: the name of the file (its path from the top directory)
#  %t: time stamp of last modification
#  %d: description from MANIFEST.new file, if any
#  %s: size of the file, in bytes

$format = 'A:%c %n';

# By default, only the source files whith the following extensions are reported
# (but a -a option will report ALL the files, and a -i option can specify some
# other extensions as well).
#  .sh .SH .c .h .l .y .man

@include = ('.sh', '.SH', '.c', '.h', '.l', '.y', '.man');

# By default, the following extensions are excluded from the list. More
# exclusions can be added with the -x option:
#  ^core .o .bak .rej .new .old .orig ,v

@exclude = ('^core', '.o', '.bak', '.rej', '.new', '.old', '.orig', ',v');

# The column separator character (or string) is used to separate each formatted
# column on the output. Formatting is requested by adding a '|' character in
# the format string. A new separator can be specified via the -C option.
# The maximum column size is fixed by the -L.

$col_separator = ' ';
$col_size = '';

&profile;					# Read ~/.dist_profile
require 'getopts.pl';
require 'stat.pl';
&usage unless &Getopts('abcdhntVi:f:p:s:w:x:C:L:I:X:');

&usage if $opt_h;
if ($opt_V) {
	print "manilist $version PL$pl\n";
	exit 0;
}

# Go to the top of the package, and update any file name given as argument
# by prepending the needed path. The process then performs a chdir to the
# top.
unless ($opt_b) {
	chop($pwd = `pwd`) unless -f '.package';
	until (-f '.package') {
		die "No .package file!  Run packinit.\n" unless $pwd;
		chdir '..' || die "Can't cd ..\n";
		$pwd =~ s|(.*)/(.*)|$1|;
		$prefix = $2 . '/' . $prefix;
	}
	if ($prefix) {
		for (@ARGV) {
			s/^\.$/$prefix/ && next;
			s/^/$prefix/ unless m|^[-/]|;
		}
	}
}

# We now are at the top level

# Build up the file hierarchy filter in @filter
foreach $entry (@ARGV) {
	$entry =~ s|/$||;			# Remove final / in directory names
	if (-d $entry) {
		push(@filter, "d:$entry");
	} elsif (-f $entry) {
		push(@filter, "f:$entry");
	} else {
		die "$entry: No such file or directory.\n";
	}
}

$prefix = '.' unless $prefix;
($top = $prefix) =~ s|/$||;
$top = '.' if $opt_t;			# Start from top, not from original dir
@ARGV = ($top) unless @ARGV;

if ($opt_n) {		# "manifest" files are found by scanning the directory
	open(MANIFEST, "find @ARGV -print|") || die "Can't run find: $!\n";
	while (<MANIFEST>) {
		chop;
		s|^./||;
		push(@manifest, $_);
	}
	close MANIFEST;
} else {
	$MANIFEST = $opt_f;
	$MANIFEST = 'MANIFEST.new' unless $opt_f;
	open(MANIFEST, $MANIFEST) || die "Can't open $MANIFEST: $!\n";
	while (<MANIFEST>) {
		chop;
		s|^./||;
		s|^(\S+)||;
		local($name) = $1;
		push(@manifest, $name);
		m|^\s+(\d+)*\s*(.*)| && ($comment{$name} = $2);
	}
	close MANIFEST;
}

# If we have to compare the files in the MANIFEST with the actual files on
# the file system, then grab them...
if ($opt_c && !$opt_n) {
	open(FILES, "find @ARGV -print|") || die "Can't run find: $!\n";
	while (<FILES>) {
		chop;
		s|^./||;
		push(@files, $_);
	}
	close FILES;
}

# If there is a patchlevel.h file, get its time stamp.
$pl_mtime = 0;
$pl_mtime = (stat('patchlevel.h'))[$ST_MTIME] if -f 'patchlevel.h';

# Dealing with command-line options
$format = $opt_p if $opt_p;
$col_separator = $opt_C if $opt_C;
$col_size = $opt_L if $opt_L;
unless ($opt_p) {		# -p may be used as a shortcut for -w and -s
	local($which) = ($format =~ /^(\w+):/);
	local($string) = ($format =~ /^\w+:(.*)/);
	$which = $opt_w if $opt_w;
	$string = $opt_s if $opt_s;
	$format = "$which:$string";
}
@include = split(' ', $opt_I) if $opt_I;		# First reset included with -I
@exclude = split(' ', $opt_X) if $opt_X;		# and excluded with -X
push(@include, split(' ', $opt_i)) if $opt_i;	# before applying additions
push(@exclude, split(' ', $opt_x)) if $opt_x;
&mode_opt;				# Compute $mode_xxx variables
&init_functions;		# Compile &included and &excluded

# Option -d requests dumping of inclusion and exclusion lists on stderr
if ($opt_d) {
	print STDERR "Included: ", join(' ', @include), "\n";
	print STDERR "Excluded: ", join(' ', @exclude), "\n";
}

@manifest = sort @manifest;
@files = sort @files if defined(@files);

# Build up the %manifest array so that we quickly know whether a file is in the
# manifest or not.
foreach (@manifest) {
	++$manifest{$_};
}

# Now loop other the files held in @manifest and perform your job...
foreach $mani (@manifest) {
	if ($opt_c && !$opt_n) {		# Check MANIFEST with actual files on disk
		for (;;) {
			$disk = $files[0];				# Next file coming up
			last unless $disk;
			last if $disk gt $mani;			# Past the current point
			shift(@files);					# Remove the file from list
			last if $disk eq $mani;			# Reached the manifest point
			# This means the file is before the current MANIFEST point
			&report($disk);					# File exists and not in MANIFEST
		}
	}
	&report($mani);
}

&flush_report;		# Flush the @Report array if formatting is needed

# Print usage and exit with a non-zero status
sub usage {
	print STDERR <<EOH;
Usage: manilist [-abcdhnptV] [-i ext] [-f manifest] [-p format] [-s string]
       [-w which] [-x ext] [-C separator] [-I included] [-L colsize]
       [-X excluded] [files]
  -a : report for all the files, regardless of (dis)allowed extensions.
  -b : take current directory as base top (do not look for .package).
  -c : check files against those in manifest and report differences.
  -d : dump include and exclude lists on stderr.
  -f : specify an alternate MANIFEST.new file.
  -h : print this help message.
  -i : specify a new extension to be included in the list of scanned files.
  -n : do not use any MANIFEST file, rather scan directories for files.
  -p : set new printing format (default is '$format'), shortcut for -s and -w.
  -s : set string to be printed (with escapes) for each file on report.
  -t : start from top directory, regardless of current dir.
  -w : give leading letter(s) for printing format (file selection on report).
  -x : give a new extension to be excluded from the list of scanned files.
  -C : specify column separator (replaces '|' in format string).
  -I : override default include list (space separated).
  -L : specify maximum column size before truncation (',' separated).
  -V : print version number.
  -X : override default exclude list (space separated).
EOH
	exit 1;
}

# Set up $mode_xxx variables, where xxx is one of the options which may be set
# in the printing mode. For instance, $mode_i is true if and only if 'i' is
# mentionnned in the printing mode.
sub mode_opt {
	local($fmt) = $format;
	$fmt =~ s/^(\w+)://;
	local($mode) = $1;
	$mode .= 'ix' if $mode =~ /a/;
	local($mode_eval) = '';
	foreach (split(//, $mode)) {
		$mode_eval .= "\$mode_$_ = 1;"
	}
	eval $mode_eval;
	chop($@) && die "Can't set mode variables: $@.\n";
}

# Write a report about a file, either on stdout or into @Report if some
# formatting post-processing is needed (aligned on '|' characters in the
# report format string).
sub report {
	local($file) = @_;
	return unless &report_wanted($file);

	local($fmt) = $format;
	local($postproc) = 0;		# Do we need formatting post-processing ?
	$fmt =~ s/^\w+://;
	$fmt =~ s/\|/\02/g && ($postproc = 1);		# Formatted colum separator

	# If neither 'd' nor 'f' is specified, then all the files are candidate
	# for report. Specifying 'df' is the same, but is less efficient.
	if (($mode_d || $mode_f) && -e $file) {		# File exists on disk
		return if -f _ && !$mode_f;
		return if -d _ && !$mode_d;
	}

	# Mode 'm' and 'n', if present, respectively ask for a report when a file
	# is in the manifest and when a file is not in the manifest. Not specifying
	# any of those modes is the same as specifying both of them.
	local($in_mani) = defined $manifest{$file};
	if ($mode_m || $mode_n) {
		return if $in_mani && !$mode_m;
		return if !$in_mani && !$mode_n;
	}

	# Mode 'i' and 'x' are used to control included and excluded files. By
	# default all the files not excluded are reported. Specifying 'x' also asks
	# for excluded files. The 'i' restricts the report to included files.
	local($included) = $mode_i ? &included($file) : 1;
	local($excluded) = &excluded($file);
	if (!$included || $excluded) {
		return if !$mode_x && $excluded;
		return if ($mode_i && !$included) && !$excluded;
	}

	local($c_macro);
	local($mtime) = (stat($file))[$ST_MTIME];
	if ($in_mani) {							# File in MANIFEST
		if (-e $file) {						# And file exists
			$c_macro = '.' if $mtime <= $pl_mtime;
			$c_macro = '>' if $mtime > $pl_mtime;
			$c_macro = 'x' if &excluded($file);
		} else {
			$c_macro = '-';
			$c_macro = '?' if &excluded($file);
		}
	} else {								# File not in MANIFEST
		if (-e $file) {						# And file exists
			$c_macro = $mtime < $pl_mtime ? 'o' : '+';
		} else {
			return if -l $file;
			warn "$file seems to have been removed...\n";
		}
	}

	# Perform the macro substitution
	$fmt =~ s/%%/\0/g;			# Escape %%
	$fmt =~ s/%/\01/g;			# Transform %, in case substitution add some
	$fmt =~ s/\01c/$c_macro/g;	# %c is the code
	$fmt =~ s/\01n/$file/g;		# %n is the file name
	$fmt =~ s/\01t/&fstamp/ge;	# %t is the time stamp
	$fmt =~ s/\01s/&fsize/ge;	# %s is the file size, in bytes
	$fmt =~ s/\01d/&mdesc/ge;	# %d is the manifest description
	$fmt =~ s/\01/%/g;			# All other %'s are left undisturbed

	print "$fmt\n" unless $postproc;
	push(@Report, $fmt) if $postproc;
}

# Format and flush report on stdout. Columns are aligned on what was originally
# a '|' character in the format string, translated into a ^B by the reporting
# routine.
sub flush_report {
	return unless @Report;		# Early return if nothing to be done
	local(@length);				# Stores maximum length for each field
	local(@max);				# Maximum allowed column sizes
	local($i);
	local($report);
	local($len);
	local(@fields);
	@max = split(',', $col_size);
	foreach $report (@Report) { # First pass: compute fields lengths
		$i = 0;
		foreach (split(/\02/, $report)) {
			$len = length($_);
			$length[$i] = $length[$i] < $len ? $len : $length[$i];
			$i++;
		}
	}
	for ($i = 0; $i < @length; $i++) {	# Adapt to maximum specified length
		$length[$i] = $max[$i] if $max[$i] > 0 && $length[$i] > $max[$i];
	}
	foreach $report (@Report) { # Second pass: formats each line
		@fields = split(/\02/, $report);
		$i = 0;
		foreach (@fields) {
			$len = length($_);
			if ($max[$i] > 0 && $len > $max[$i]) {
				$_ = substr($_, 0, $max[$i]);		# Truncate field
			} else {
				$_ .= ' ' x ($length[$i] - $len);	# Pad with blanks
			}
			$i++;
		}
		print join($col_separator, @fields), "\n";
	}
}

# The following macro subsitution functions are called with $file set

# Return the modification time on file
sub fstamp {
	(stat($file))[$ST_MTIME];
}

# Return the file size, in bytes
sub fsize {
	(stat($file))[$ST_SIZE];
}

# Return the description from the MANIFEST file, if any
sub mdesc {
	return '' unless defined $comment{$file};
	$comment{$file};
}

# Do we have to report informations on the specified file?
sub report_wanted {
	return 1 unless @filter;
	local($file) = @_;
	local($filter);
	foreach (@filter) {
		$filter = $_;		# Work on a copy
		if ($filter =~ s/^d://) {
			return 1 if $file =~ m|^$filter(/[^/]*)*|;
		} else {
			$filter =~ s/^f://;
			return 1 if $filter eq $file;
		}
	}
	return 0;
}

# Build up the 'included' and 'excluded' functions which return true if a file
# is in the include or exclude set.
sub init_functions {
	&build_function('included', *include, 1);
	&build_function('excluded', *exclude, 0);
}

# Build a function which returns true if a given name is found in the array
# list of regular expression. Each regular expression is applied on the file
# name, anchored at the end. False is returned only if none of the expressions
# match. The purpose of building such a function dynamically is to avoid the
# costly pattern recompilation every time.
sub build_function {
	local($name) = shift(@_);	# The name of the function to be built
	local(*array) = shift(@_);	# The extension array we have to check with
	local($dflt) = shift(@_);	# Default value when -a is used
	local($fn) = &q(<<EOF);		# Function being built.
:sub $name {
:	return $dflt if \$opt_a;	# All files are included, none excluded.
:	local(\$_) = \@_;
:	study;
EOF
	foreach (@array) {
		$ext = $_;			# Work on a copy
		# Convert shell-style globbing into perl's RE meta-characters
		$ext =~ s/\./\\./g;	# Escape .
		$ext =~ s/\?/./g;	# ? turns into .
		$ext =~ s/\*/.*/g;	# And * turns into .*
	$fn .= &q(<<EOL);
:	return 1 if /$ext\$/;
EOL
	}
	$fn .= &q(<<EOF);
:	0;	# None of the extensions can be applied to the file
:}
EOF
	eval $fn;
	chop($@) && die "Can't compile '$name':\n$fn\n$@.\n";
}

# Remove ':' quotations in front of the lines
sub q {
	local($_) = @_;
	local($*) = 1;
	s/^://g;
	$_;
}

!NO!SUBS!
$grep -v '^;#' ../pl/tilde.pl >> manilist
$grep -v '^;#' ../pl/profile.pl >> manilist
chmod 755 manilist
$eunicefix manilist

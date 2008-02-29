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
echo "Extracting jmake/fixcpp (with variable substitutions)"
$spitshell >fixcpp <<!GROK!THIS!
$startperl
	eval 'exec perl -S \$0 "\$@"'
		if \$runnning_under_some_shell;

# $Id: fixcpp.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.1  1995/03/21  08:35:37  ram
# patch52: created
#

# Thank you HP-UX for having a cpp that strips trailing backslashes in the
# text. As of today, you are the only reason for this program to exist.
# People designing such things should have their hands cut off to prevent
# them from doing further damage :-)
#
# This program is meant to be called from jmake. All it does is pre-process
# the file it is given as argument, focusing on #include directives and
# resolving them as cpp would (but without the #line stuff since we don't
# really care about it), escaping all the trailing \ into '\ ^M'. The resulting
# temporary file is then handed off to the real cpp for macro processing, and
# the output is printed on stdout, after restoration of any original trailing \.
# Again, thanks HP-UX for making this so challenging and exciting... :-)
#
# Note that we MUST leave alone all the trailing @!\ or @@\, since those appear
# in macros and must go away some way or the other. Also trailing backslashes
# on #define lines are really continuations and are left un-escaped.

\$cpp = '$cpp';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
$spitshell >>fixcpp <<'!NO!SUBS!'

while ($ARGV[0] =~ /^-/) {
	$_ = shift;
	last if /--/;
	$cpp_opt .= "$_ ";
	next unless s/-I//;
	push(@lookpath, $_);
}

($file) = @ARGV;
$counter = 0;					# Counter for temporary files

$SIG{'INT'} = 'PLUMBER';		# Install cleaner in case of an interrupt...

$result = &process($file);		# Process file, result in a temporary
&cpp($result);					# Pass resulting file with escaped \ to cpp
unlink $result;
exit 0;

# Cleanup any temporary files...
sub PLUMBER {
	warn "Could not cleanup all temporaries.\n" if @tmps != unlink(@tmps);
	exit 1;
}

# Compute a suitable temporary file name
sub mktmp {
	$counter++;
	local($tmp) = "/tmp/jmk.$counter.$$";
	push(@tmps, $tmp);			# Keep track of them for &PLUMBER...
	$tmp;
}

# Process a given file, returning the name of the temporary file into which
# the result is left over.
# This routine is recursively called to process nested include directives.
sub process {
	local($file) = @_;
	local(*FILE, *TMP);
	open(FILE, $file) || die "Can't read $file: $!\n";
	local($tmpfile) = &mktmp;
	open(TMP, ">$tmpfile") || die "Can't create $tmpfile: $!\n";
	local($here, $include);
	local($_);
	while (<FILE>) {
		if (s/^#\s*include\s*//) {		# Ah, we found a #include something...
			chop;
			if (/"(\S+)"/) {
				($include, $here) = ($1, 1);
			} elsif (/<(\S+)\>/) {
				($include, $here) = ($1, 0);
			} else {
				warn "Ignoring unkown include directive $_.\n";
				next;
			}
			local($incfile) = &lookup($include, $here);
			unless (defined $incfile) {
				warn "Can't locate include file $include.\n";
				next;
			}
			$include = &process($incfile);	# Recursively process this file
			&append($include, 'TMP');		# Append result to current tmp file
			unlink $include;
		} else {
			&escape;
			print TMP;
		}
	}
	close FILE;
	close TMP;
	$tmpfile;	# Return name of file where results has been left over
}

# Perform necessary escaping work on current line.
sub escape {
	# Don't escape trailing backslashes in macro definition or cpp
	# won't see them as macro continuation any longer, and also within
	# macro definitions, all those @@ or @! continuations...
	s/\\$/\\ \015/ unless /\@[!@]\\$/ || /^#define/;
}

# Append file to given (opened) file descriptor
sub append {
	local($file, $fd) = @_;
	local(*FILE);
	open(FILE, $file) || die "Can't re-open $file: $!\n";
	local($_);
	while (<FILE>) {
		&escape;
		print $fd $_;
	}
	close FILE;
}

# Lookup file, returning its located name or undef if not found.
sub lookup {
	local($file, $here) = @_;
	unless ($here) {
		foreach $dir (@lookpath) {
			if (-r "$dir/$file") {		# Use -r instead of -f for symlinks
				$file = "$dir/$file";
				last;
			}
		}
	}
	return undef unless -r $file;
	$file;
}

# This is the final cpp processing. The output from cpp is filtered to un-escape
# all the trailing backslashes.
sub cpp {
	local($file) = @_;
	open(CPP, "$cpp $cpp_opt $file |") || die "Can't fork: $!\n";
	while (<CPP>) {
		s/\\ \015$/\\/;				# Un-escape trailing \
		print STDOUT;
	}
	close CPP;
}

!NO!SUBS!
chmod 755 fixcpp
$eunicefix fixcpp

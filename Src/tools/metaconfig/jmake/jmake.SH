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
echo "Extracting jmake/jmake (with variable substitutions)"
$spitshell >jmake <<!GROK!THIS!
$startperl
	eval 'exec perl -S \$0 "\$@"'
		if \$runnning_under_some_shell;

# $Id: jmake.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.6  1995/09/25  09:08:01  ram
# patch59: will now force macro definitions to the left
#
# Revision 3.0.1.5  1995/07/25  13:34:47  ram
# patch56: all error messages are now prefixed with the program name
#
# Revision 3.0.1.4  1995/03/21  08:45:27  ram
# patch52: now invokes cpp through new fixcpp script
# patch52: first pass now skips cpp comments alltogether
#
# Revision 3.0.1.3  1994/10/29  15:47:01  ram
# patch36: added various escapes in strings for perl5 support
#
# Revision 3.0.1.2  1993/08/24  12:12:50  ram
# patch3: privlib dir was ~name expanded in the wrong place
#
# Revision 3.0.1.1  1993/08/19  06:42:13  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:17  ram
# Baseline for dist 3.0 netwide release.
#

\$dir = '$privlib/files';
\$cpp = '$cpp';
\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
$spitshell >>jmake <<'!NO!SUBS!'

($me = $0) =~ s|.*/(.*)|$1|;
$dir = &tilda_expand($dir);		# ~name expansion
$file = $dir . '/Jmake.tmpl';

$cpp_opt = "-I. ";				# For Jmakefile, which is local
while ($ARGV[0] =~ /^-/) {
	$_ = shift;
	last if /--/;
	$cpp_opt .= "$_ ";
}
$cpp_opt .= "-I$dir";

# Thank you HP-UX for having a cpp that blindly strips trailing backslashes
# in the text. Run through cpp by using the fixcpp script...

open(CPP, "$dir/fixcpp $cpp_opt $file |");
while (<CPP>) {
	# Record defined symbols in Jmakefile. We won't catch symbols
	# in conditional commands, but that's ok, I hope.
	if ($in_symbol) {
		$val = $_;
		$in_symbol = 0 if !($val =~ s/\\\s*$//);	# Last line
		if ($val = /^\|expand/) {		# Found an expand command
			$in_symbol = 0;				# Stop gathering value
			$val .= "void::x";			# Stop any incomplete escape sequence
		}
		chop($val);
		$Makesym{$current_symbol} .= $val;
	} elsif (/^\s*(\w+)\s*=(.*)/ && !$in_symbol) {
		# Found a makefile's macro declaration
		$val = $2;
		$current_symbol = $1;
		if ($val =~ s/\\\s*$//) {	# Remove final '\'
			$in_symbol = 1;			# This is a continuation line
		}
		$Makesym{$current_symbol} = $val;
		push(@Order, $current_symbol);	# Keep track of order
	}
	# Protect RCS keyword Id or Header from normal substitution
	s/\$(Id|Header|Log)/\$X-$1/;
	# Restore possibly escaped C comments
	s|/#\*|/*|g;
	s|\*#/|*/|g;
	# Remove all ^^ (null space character)
	s|\^\^||g;
	# Restore escaped ^^ sequence
	s|\^\\\^|^^|g;
	next if /^#\s+\d+/;		# Skip cpp commments

	s/^;#/#/;
	s/@#\s?/\n/g;		# Kept for backward compatibility
	s/@!\s?/\n/g;
	s/@@\s?/\n\t/g;

	$* = 1;
	# A '\r' is added to all lines, in order to let 'split' keep them
	# As lines ending with '\' won't fit in the next regular
	# expression (why ?), we have to treat that special case separately
	s/\n$/\r\n/g;
	s/\\\s*$/\\\r/g;	# Remove spaces after final '\' and add '\r'
	$* = 0;
	@macro = split(/\n/);
	for ($i = 0; $i <= $#macro; $i++) {
		chop($_ = $macro[$i]);				# Remove final '\r'
		s/\s+$//g;							# Remove possible useless spaces
		if (/^TOP\s*=\s*(\S+)/) {			# Get the top from generated file
			$top = $1;
		}
		if (s/^\s*>//) {					# '>' means "symbol wanted"
			$symbol{$_} = 1;
		} elsif (s/^\s*\+//) {				# '+' means "initialization section"
			if (s/^\+(\w+)//) {				# '++' means add to variable list
				$added{$1} .= $_;
			} else {						# A single '+' means "add as is".
				push(@init, $_);
			}
		} elsif (s/^\|//) {					# Command for us
			if (/suffix\s+(\S+)/) {			# Add suffix
				push(@suffix, $1) unless $seen{$1};
				$seen{$1} = 1;
			} elsif (s/^rule://) {			# Add building rule
				s/^\s(\s*\S+)/\t$1/;		# Make sure leading tab is there
				push(@rule, $_);
			} elsif (/^skip/) {				# Unconditional skip... funny!
				push(@makefile, "|$_");		# Skip handled in pass 2
			} elsif (/^expand/) {
				push(@makefile, "|$_");		# Expand handled in pass 2
			} elsif (/^once\s+(\S+)/) {		# Once handled in pass 1
				if ($Once{$1}++) {			# Symbol already seen -- skip
					for (; $i <= $#macro; $i++) {
						last if $macro[$i] =~/^-once/;
					}
					warn("$me: -once not found for $1")
						unless $macro[$i] =~/^-once/;
				}
			} else {
				print "$me: Warning: unknown command $_\n";
			}
		} else {
			next if /^-once/;			# Control statement removed
			push(@makefile, $_);
		}
	}
}
close CPP;

@key = keys(%added);
$last_was_blank = 1;	# To avoid blank line at the top of the file
$symbol{'INIT'} = 1 if ($#init >= 0 || $#key >=0);		# Initializations
$symbol{'SUFFIX'} = 1 if ($#suffix >= 0 || $#rule >=0);	# Rules or suffixes
$symbol{'TOP'} = 1 if $top eq '.';		# If imake invoked for the top

open(MAKEFILE, ">Makefile.SH");
# We have to use for instead of foreach to handle 'skip' easily
line: for ($i = 0; $i <= $#makefile; $i++) {
	$_ = $makefile[$i];
	next if /^-skip|-expand/;		# They might have made a mistake

	s/<TAG>/[jmake $version PL$patchlevel]/;
	if (/^\s*$/) {
		next if ($last_was_blank);
		$last_was_blank = 1;
	} else {
		$last_was_blank = 0;
	}

	# Lines starting with ?SYMBOL: (resp. %SYMBOL:) are to be processed
	# only if SYMBOL is defined (resp. undefined).

	# Apply in sequence
	while (/^\s*\?|\s*%/) {
		if (s/^\s*\?(\w+)://) {					# Wanted symbol ?
			next line unless $symbol{$1};
		} elsif (s/^\s*%(\w+)://) {				# Unwanted symbol ?
			next line if $symbol{$1};
		} else {
			print "$me: Warning: missing ':' in $_\n";
			last;
		}
	}

	# We wish to make sure there is a leading tab if the line starts with
	# a space to prevent problems later on. However, variable definitions
	# might want to be aligned on the '=' (imake style). Not all make
	# may be able to cope with those though, so they are left justified
	# again.

	s/^\s/\t/ unless /^\s+\w+\s+=/;		# Make sure leading tab is there
	s/^\s+(\w+\s+=)/$1/;				# Left justify variable definition
	s/^;#/#/;							# Comments in Jmakefile

	if (s/^\|//) {							# Command for us
		if (/^skip/) {						# Skip until -skip
			for (; $i <= $#makefile; $i++) {
				last if $makefile[$i] =~ /^-skip/;
			}
		} elsif (s/^expand//) {
			do init_expand($_);			# Initializes data structures
			$i++;						# Skip expand line
			undef @Expand;				# Storage for expanded lines
			$pattern = '';				# Assume no pattern
			for (; $i <= $#makefile; $i++) {
				$_ = $makefile[$i];
				if (s/^-expand//) {			# Reached end of expansion
					if (s/^\s*(.*)/$1/) {	# Expand followed by a pattern
						$pattern = $_;		# Get pattern to be removed
					}
					last;
				}
				s/^\s/\t/;				# Make sure leading tab is there
				push(@Expand, $_);		# Line to be expanded
			}
			do expand($pattern);		# Expand all lines in buffer
		} else {
			print "$me: Warning: unknown command $_\n";
		}
	} elsif (/^INIT/) {						# Initialization section
		# All the initializations are put in the variable substitution
		# section of the Makefile.SH. Therefore, we have to protect all
		# the '$' signs that are not followed by an alphanumeric character.
		foreach (@init) {
			# Dumps core sometimes with perl 4.0 PL10
			# do protect_dollars(*_);
			$_ = do protect_dollars($_);
			do print_makefile($_);
		}
		foreach (@key) {	# @key set earlier to keys(%added)
			$_ .= " = " . $added{$_};
			# Dumps core sometimes with perl 4.0 PL10
			# do protect_dollars(*_);
			$_ = do protect_dollars($_);
			do print_makefile($_);
		}
	} elsif (/^SUFFIX/) {					# Suffixes/Rules section
		# Rules and suffixes are put in the variable substitution
		# section of the Makefile.SH. Therefore, we have to protect all
		# the '$' signs that are not followed by an alphanumeric character.
		if ($#suffix >= 0) {
			print MAKEFILE ".SUFFIXES:";
			foreach (@suffix) {
				# Dumps core sometimes with perl 4.0 PL10
				# do protect_dollars(*_);
				$_ = do protect_dollars($_);
				print MAKEFILE " $_";
			}
			print MAKEFILE "\n\n";
		}
		foreach (@rule) {
			# Dumps core sometimes with perl 4.0 PL10
			# do protect_dollars(*_);
			$_ = do protect_dollars($_);
			print MAKEFILE "$_\n";
		}
	} else {
		do print_makefile($_);
	}
}
close MAKEFILE;

sub protect_dollars {
	# Dumps core sometimes with perl 4.0 PL10
	# local(*_) = shift(@_);
	s/\\\$/\\=/g;		# Protect already escaped '$'
	s/(\$\W)/\\$1/g;	# Escape unprotected '$'
	s/\\=/\\\$/g;		# Restore escaped '$'
	$_;					# Because perl dumps core... :-(
}

# Initializes data structures for expansion. If we detect Makefile
# macro in the 'expand' line (the argument), then we write a small
# makefile that will do the substitution for us -- I'm lazy today :-)
sub init_expand {
	local($_) = shift(@_);
	undef %Vars;		# Reset array of variables
	$Vars_len = 0;		# Number of "symbols" in first expanded
	if (/\$\(\w+\)/) {	# If at least one macro
		local($make) = "/tmp/mkjm$$";
		open(MAKE, ">$make") || die "$me: can't create $make: $!\n";
		do gen_variables();			# Generates already computed variables
		foreach $var (@Order) {		# Print each in order we found them
			print MAKE "$var = $Makesym{$var}\n" if !$Gvars{$var};
		}
		print MAKE "all:\n\t\@echo '$_'\n";
		close MAKE;
		chop($_ = `make -f $make all`);
		unlink($make);
	}
	while (s/^\s*(\w+)!([^!]*)!//) {
		$Vars{$1} = $2;
		# Record only length for _first_ expanded symbol
		$Vars_len = split(/\s\s*/, $2) unless $Vars_len;
	}
}

# Expand lines in the @Expand array. The argument is a pattern which is to
# be removed from the last chunk of expanded lines.
# For each symbol s, !s is replaced by the next item, and !s:p=q does the
# same after having replaced the pattern 'p' by pattern 'q' in the item.
# Spaces are NOT allowed in 'p' or 'q'. Substitution is done once (no /g).
sub expand {
	local($pattern) = shift;		# To-be-removed pattern for last chunk
	local($_);
	local($sub);
	local($i);
	local(@expands);
	for ($i = 0; $i < $Vars_len; $i++) {
		foreach $line (@Expand) {
			$_ = $line;		# Don't modify elements in array
			foreach $sym (keys %Vars) {
				@expands = split(/\s\s*/, $Vars{$sym});
				$sub = $expands[$i];
				$sub =~ s/\/\///g;		# // is a void value
				while (s/!${sym}:([^\s]*)=([^\s]*)/,x##x,/) {
					# Replacing item is altered by some pattern
					local($p) = $1;
					local($q) = $2;
					local($subq) = $sub;
					eval "\$subq =~ s=${p}=${q}=";
					s/,x##x,/${subq}/;
				}
				s/!${sym}/${sub}/g;
			}
			# Protect substitution in an 'eval' in case of error
			eval "s/${pattern}\$//" if $pattern && $i == ($Vars_len - 1);
			do print_makefile($_);
		}
	}
}

# Prints its argument in MAKEFILE and records it also in Generated
sub print_makefile {
	local($_) = shift(@_);		# Line to be printed
	print MAKEFILE "$_\n";
	push(@Generated, "$_\n");
}

# Generates in MAKE file all the generated variable we have so far for
# final Makefile. This is mainly intended to allow expansion of variables
# which are already defined with an expand.
sub gen_variables {
	undef %Gvars;				# Reset already generated variables
	local ($in_symbol) = 0;		# True when in variable (Makefile's macro)
	foreach (@Generated) {
		if ($in_symbol) {
			if (/^\s*(\w+)\s*=(.*)/) {		# Missed the end of previous macro
				$in_symbol = 0;
				$Gvars{$1} = 1;					# Definition of variable seen
				$in_symbol = 1 if (/\\\s*$/);	# There is a final '\'
				print MAKE "void::\n";			# Cut incomplete esc sequence
			} else  {
				$in_symbol = 0 if !(/\\\s*$/);	# Last line
			}
			print MAKE;
		} elsif (/^\s*(\w+)\s*=(.*)/ && !$in_symbol) {
			# Found a makefile's macro declaration
			$Gvars{$1} = 1;					# Definition of variable seen
			$in_symbol = 1 if (/\\\s*$/);	# There is a final '\'
			print MAKE;
		}
	}
	print MAKE "void::\n";		# Cut incomplete escape sequence
}

!NO!SUBS!
$grep -v '^;#' ../pl/tilde.pl >>jmake 
chmod 755 jmake
$eunicefix jmake

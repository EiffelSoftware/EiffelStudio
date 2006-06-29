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
echo "Extracting bindex (with variable substitutions)"
$spitshell >bindex <<!GROK!THIS!
$startperl
!GROK!THIS!
$spitshell >>bindex <<'!NO!SUBS!'
	eval 'exec perl -S $0 "$@"'
		if $runnning_under_some_shell;

# $Id: bindex.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.1  1993/08/19  06:42:12  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:13  ram
# Baseline for dist 3.0 netwide release.
#

$file = "files/Jmake.rules";

open(INDEX, ">Index") || die "Cannot create Index.\n";
open(RULES, "$file") || die "Cannot open $file.\n";

print INDEX
"[This Index is automatically generated from Jmake.rules file. Do not
edit this file or your changes will be lost. Edit Jmake.rules instead.]

This file contains a listing of all the macros that can be used in a
Jmakefile. Only a few of these should be used in the Jmakefile (they
are the top-level macros). However, some low-level ones may be useful,
but it is up to you to make that decision. This explains why this file
holds all the available macros for jmake.

In the following listing, the macros are separated by a line of dashes.
The signature of the macro is given, then a small comment of what it
does precedes the actual definition.

Lines preceded by '->' show the set of symbols defined when the macro is
used. Initialization lines are shown as-is, i.e. have the form SYM = val
while concatenation is shown by SYM += val (which means val is added to
the value of SYM).

Conditional lines are preceded by tests like (if SYM). This means the line
is to be kept if and only if the symbol SYM is defined. Other internal
requests are not formatted yet.

";
$inrule = 0;			# Not inside a rule at the beginning
$incomment = 0;			# Not inside a comment
$last_was_text = 0;		# Last line was not a rule text
while (<RULES>) {
	$inrule || next unless /^\s\*\s(\w+)\s*:/;
	if ($inrule) {		# We are already in a rule
		if ($incomment) {
			if (m|^\s*\*/|) {	# End of comment
				$incomment = 0;
				$Comment{$current} .= "\n";
			} else {
				s/^\s*\*\s*//;	# Remove leading comment sign
				$Comment{$current} .= "    $_";
			}
			next;		# Anyway, go to next line
		}
		if (/^\s*$/) {		# Empty line = end of rule
			$inrule = 0;
			next;
		}
		# Here, we have to print the body of the rule, after some cleaning
		s/(@#|@@|@!)\\$//;		# Remove final continuations
		s/^(#define.*)\\/$1/;	# Remove single '\' on first rule line
		s/\|rule:\s*$/\n/;
		s/\|rule:\s+/    /;		# Remove rule markers
		s/\|rule://;
		s/%(\w+):\|skip/#ifdef $1/;		# Deal with ugly skip syntax
		s/\?(\w+):\|skip/#ifndef $1/;	# Deal with ugly skip syntax
		s/\-skip/#endif/;
		s/\?(\w+):/(if $1) /;	# Simple '?' test
		s/%(\w+):/(not $1) /;	# Simple '%' test
		s/\|suffix/.SUFFIXES:/;	# Make suffix command explicit
		s/\t/    /g;			# Expand all tabs to 4 chars
		s/\s*$/\n/;				# Remove any trailing space
		s|\^\^|/**/|;			# Restore ^^ to the more visual /**/
		if (/^$/) {				# If empty line
			$Index{$current} .= "\n" if $last_was_text;
			$last_was_text = 0;
			next;
		}
		if (/^[>+]/) {			# Special commands
			if (s/^>\s*//) {						# Wanted symbol
				chop;
				$Wants{$current} .= " $_";
			} elsif (/^\+\+\s*(\S+)\s*(.*)/) {		# Added symbol
				$Added{$current} .= "\t$1 += $2\n";
			} else {
				s/^\+\s*(.*)//;
				$Init{$current} .= "\t$1\n";
			}
			next;
		}
		if (s/^#define\s+//) {	# Definition of the rule
			chop;
			$Sig{$current} = $_;			# Signature of rule
		} else {
			$Index{$current} .= "    $_";	# Rule's body
			$last_was_text = 1;
		}
	} else {			# We've just entered a rule
		$current = $1;
		next if $current =~ /patch\d/;	# Skip RCS log messages
		$inrule = 1;
		$incomment = 1;	# We're still in the leading comment
		$Seen{$current} = 1;
		$last_was_text = 0;
	}
}
close RULES;

# Now sort the rules in alphabetical order

print INDEX '-' x 72, "\n";
foreach $rule (sort(keys %Seen)) {
	print INDEX "$Sig{$rule}:\n";
	print INDEX $Comment{$rule};
	$line = $Wants{$rule};
	if (length($line)) {
		$line = "->$line.";
		$line = do format($line);
		print INDEX "$line\n";
	}
	$line = $Init{$rule};
	print INDEX "$line\n" if length($line);
	$line = $Added{$rule};
	print INDEX "$line\n" if length($line);
	$line = $Index{$rule};
	print INDEX $line;
	print INDEX "\n" if (length($line));
	print INDEX '-' x 72, "\n";
}

close INDEX;

# Format $_ to fit in 80 columns (70 + size of tabs)
# Long lines are split, and the all but the first are indented
# by two leading spaces. The whole thing is then indented by
# one tab.
sub format {
	local($tmp);
	local($head) = '';
	local($_) = shift(@_);
	while (length($_) > 70) {
		$tmp = substr($_,0,70);
		$tmp =~ s/^(.*) .*/$1/;
		$head .= "\t$tmp\n";
		$_ = ' ' . substr($_,length($tmp),9999);
	}
	$head .= "\t$_\n";
}
!NO!SUBS!
chmod 755 bindex
$eunicefix bindex

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
echo "Extracting mcon/makegloss (with variable substitutions)"
$spitshell >makegloss <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

!GROK!THIS!
$spitshell >>makegloss <<'!NO!SUBS!'
# $Id: makegloss.SH 78389 2004-11-30 00:17:17Z manus $
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
# Revision 3.0.1.3  1994/01/24  14:17:49  ram
# patch16: now understands internal-use only defined variables
#
# Revision 3.0.1.2  1993/10/16  13:50:39  ram
# patch12: updated to support new ?M: lines
#
# Revision 3.0.1.1  1993/08/19  06:42:21  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:10:12  ram
# Baseline for dist 3.0 netwide release.
#

open(G,">Glossary") || die "Can't create Glossary.\n";
print G
'[This Glossary is automatically generated from the Unit files.  Do not edit
this file or your changes will be lost.  Edit the appropriate Unit instead.]

This file contains a listing of all the C preprocessor symbols and shell
variables whose value can be determined by a Configure script.  For the
most part, any symbol in UPPERCASE is a C preprocessor symbol, and
will be defined in config.h.  Symbols in lowercase are shell variables,
and are defined in config.sh.

If you write your shell scripts and C programs in terms of these symbols,
metaconfig can automatically build you a Configure script that will determine
the value of those symbols.  See the README file for a description of how
to use metaconfig.

In the following listing, the Unit: line indicates the name of the unit
where this symbol is defined, and the Wants: line indicates what other
symbols must be determined in order to figure out the value of this one.
If there is an "(Also defines ...)" entry, it indicates what other symbols
are defined by the Unit other than the one corresponding to the unit name.

Variable of the form d_* either have the value "define" or "/*define", and
control whether some C preprocessor symbol gets defined or not.

';

@ARGV = <U/*.U>;
while (<>) {
	if (/^\?[\w\-]+:/) { 	# We may have found a control line
		# Long lines may be escaped with a final backslash
		$_ .= &complete_line if s/\\\s*$//;
	}
	if (/^\?MAKE:.*:/) {
		($also, $wants) = /^\?MAKE:\s*(.*):\s*(.*)/;
		($unit = $ARGV) =~ s|.*/(.*)\.U$|$1|;
		@Also = split(/ /, $also);
		$also = '';
		$internal = '';
		foreach (@Also) {
			if (s/^\+//) {
				$internal .= "$_ ";
			} else {
				$also .= "$_ ";
			}
		}
		$also =~ s/$unit\s//;
		chop($also);
		chop($internal);
		@Wants = split(/ /, $wants);
		$wants = '';
		$option = '';
		foreach (@Wants) {
			if (s/^\+//) {
				$option .= "$_ ";
			} else {
				$wants .= "$_ ";
			}
		}
		chop($option);
		chop($wants);
		$head = '';
		$_ = "Unit: $unit";
		$_ .= " (Also defines $also)" if $also;
		$_ .= " (With private $internal)" if $internal;
		$head .= do format($_);
		if ($wants) {
			$_ = "Wants: $wants";
			$head .= do format($_);
		}
		if ($option) {
			$_ = "Optional: $option";
			$head .= do format($_);
		}
		$head .= "\n";
	}

	# Example of expression matched by the following pattern:
	#   ?C:symbol ~ alias (obsolete list):
	# The main symbol (optionally aliased) can be followed by a list of
	# obsolete symbols (the list is space separated).

	if (/^\?[CS]:(\w+)(\s*~\s*\S+)?\s*(\(.*\))?:\s*$/) {
		$sym = $1;
		$obsoleted = $3;
		push(@syms, $sym);
		$header{$sym} .= $head;
		if ($obsoleted =~ s/^\((.*)\)$/$1/) {
			@obsoleted = split(' ', $obsoleted);
			foreach $obs (@obsoleted) {
				push(@syms, $obs);
				$header{$obs} = "\tObsoleted by $sym.\n\n";
			}
		}
	}
	elsif (s/^\?[CS]://) {		# Must be inside definition
		if (/^\.$/) {			# Closing line
			$def{$sym} .= "\n";
			$sym = '';
		}
		else {
			s/^(\t|  ? ? ? ? ? ? ?)//;
			$def{$sym} .= "\t" . $_;
		}
	}
	elsif (/^\?M:(\w+):\s*([\w\s]*)\n$/) {	# Magic mapping introduction
		$sym = $1;
		$cdep = $2;
		push(@syms, $sym);
		$cdep =~ s/^\s*//;
		$cdep = ", needs: $cdep" if $cdep ne '';
		$header{$sym} = "\tMagic symbol$cdep\n" . $head;
	}
	elsif (s/^\?M://) {			# Must be a magic mapping definition
		if (/^\.$/) {			# Closing line
			$def{$sym} .= "\n";
			$sym = '';
		} else {
			$def{$sym} .= "\t" . $_;
		}
	}
}

foreach $sym (sort @syms) {
	print G "$sym:\n";
	print G $header{$sym};
	print G $def{$sym};
}
close G;

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

# The first line was escaped with a final \ character. Every following line
# is to be appended to it (until we found a real \n not escaped). Note that
# the leading spaces of the continuation line are removed, so any space should
# be added before the former \ if needed.
sub complete_line {
	local($_);
	local($read) = '';		# Concatenation of all the continuation lines found
	while (<>) {
		s/^\s+//;				# Remove leading spaces
		if (s/\\\s*$//) {		# Still followed by a continuation line
			$read .= $_;	
		} else {				# We've reached the end of the continuation
			return $read . $_;
		}
	}
}

!NO!SUBS!
chmod 755 makegloss
$eunicefix makegloss

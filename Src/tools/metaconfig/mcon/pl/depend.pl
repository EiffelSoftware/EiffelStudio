;# $Id: depend.pl 78389 2004-11-30 00:17:17Z manus $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log$
;# Revision 1.1  2004/11/30 00:17:18  manus
;# Initial revision
;#
;# Revision 3.0.1.3  1995/09/25  09:18:56  ram
;# patch59: new ?Y: directive to change unit layout
;#
;# Revision 3.0.1.2  1994/10/29  16:35:23  ram
;# patch36: added various escapes in strings for perl5 support
;#
;# Revision 3.0.1.1  1993/10/16  13:54:35  ram
;# patch12: added minimal support for ?P: lines (not ready yet)
;#
;# Revision 3.0  1993/08/18  12:10:21  ram
;# Baseline for dist 3.0 netwide release.
;#
;# Metaconfig-dependent part of the dependency extraction.
;#
# Process the ?W: lines
sub p_wanted {
	# Syntax is ?W:<shell symbols>:<C symbols>
	local($active) = $_[0] =~ /^([^:]*):/;		# Symbols to activate
	local($look_symbols) = $_[0] =~ /:(.*)/;	# When those are used
	local(@syms) = split(/ /, $look_symbols);	# Keep original spacing info
	$active =~ s/\s+/\n/g;						# One symbol per line

	# Concatenate quoted strings, so saying something like 'two words' will
	# be introduced as one single symbol "two words".
	local(@symbols);				# Concatenated symbols to look for
	local($concat) = '';			# Concatenation buffer
	foreach (@syms) {
		if (s/^\'//) {
			$concat = $_;
		} elsif (s/\'$//) {
			push(@symbols, $concat . ' ' . $_);
			$concat = '';
		} else {
			push(@symbols, $_) unless $concat;
			$concat .= ' ' . $_ if $concat;
		}
	}

	# Now record symbols in master and wanted tables
	foreach (@symbols) {
		$cmaster{$_} = undef;					# Asks for look-up in C files
		$cwanted{$_} = "$active" if $active;	# Shell symbols to activate
	}
}

# Process the ?INIT: lines
sub p_init {
	local($_) = @_;
	print INIT "?$unit:", $_;		# Wanted only if unit is loaded
}

# Process the ?D: lines
sub p_default {
	local($_) = @_;
	s/^([A-Za-z_]+)=(.*)/\@if !$1\n%$1:$1=$2\n\@define $1\n\@end/
		&& ($hasdefault{$1}++, print INIT $_);
}

# Process the ?P: lines
sub p_public {
	local($_) = @_;
	local($csym);					# C symbol(s) we're trying to look at
	local($nosym);					# List of symbol(s) which mustn't be wanted
	local($cfile);					# Name of file implementing csym (no .ext)
	($csym, $nosym, $cfile) = /([^()]+)\s*(\(.*\))\s*:\s*(\S+)/;
	unless ($csym eq '' || $cfile eq '') {
		# Add dependencies for each C symbol, of the form:
		#	-pick public <sym> <file> <notdef symbols list>
		# and the file will be added to config.c whenever sym is wanted and
		# none of the notdef symbols is wanted.
		foreach $sym (split(' ', $csym)) {
			$dependencies .= "\t-pick public $sym $cfile $nosym\n";
		}
	}
}

# Process the ?Y: lines
# Valid layouts are for now are: top, bottom, default.
#
# NOTA BENE:
# This routine relies on the $defined variable, a global variable set
# during the ?MAKE: processing, which lists all the defined symbols in
# the unit (the optional leading '+' for internal symbols has been removed
# if present).
#
# The routine fills up a %Layout table, indexed by symbol, yielding the
# layout imposed to this unit. That table will then be used later on when
# we sort wanted symbols for the Makefile.
sub p_layout {
	local($_) = @_;
	local($layout) = /^\s*(\w+)/;
	$layout =~ tr/A-Z/a-z/;		# Case is not significant for layouts
	unless (defined $Lcmp{$layout}) {
		warn "\"$file\", line $.: unknown layout directive '$layout'.\n";
		return;
	}
	foreach $sym (split(' ', $defined)) {
		$Layout{$sym} = $Lcmp{$layout};
	}
}

# Process the ?L: lines
# There should not be any '-l' in front of the library name
sub p_library {
	&write_out("L:$_");
}

# Process the ?I: lines
sub p_include {
	&write_out("I:$_");
}

# Write out line in file Extern.U. The information recorded there has the
# following prototypical format:
#   ?symbol:L:inet bsd
# If 'symbol' is wanted, then 'inet bsd' will be added to $libswanted.
sub write_out {
	local($_) = @_;
	local($target) = $defined;		# By default, applies to defined symbols
	$target = $1 if s/^(.*)://;		# List is qualified "?L:target:symbols"
	local(@target) = split(' ', $target);
	chop;
	foreach $key (@target) {
		print EXTERN "?$key:$_\n";	# EXTERN file defined in xref.pl
	}
}


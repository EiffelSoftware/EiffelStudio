;# $Id: xref.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1995/09/25  09:20:05  ram
;# patch59: added empty p_layout stub for new ?Y: directives
;#
;# Revision 3.0.1.1  1993/10/16  13:56:23  ram
;# patch12: declared p_public for ?P: lines
;#
;# Revision 3.0  1993/08/18  12:10:31  ram
;# Baseline for dist 3.0 netwide release.
;#
;# Metaxref-dependent part of the dependency extranction.
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

	local($fake);		# Fake unique shell symbol to reparent C symbol

	# Now record symbols in master and wanted tables
	foreach (@symbols) {
		$cmaster{$_} = undef;					# Asks for look-up in C files
		# Make a fake C symbol and associate that with the wanted symbol
		# so that later we know were it comes from
		$fake = &gensym;
		$cwanted{$_} = "$fake";					# Attached to this symbol
		push(@Master, "?$unit:$fake=''");		# Fake initialization
	}
}

# Ingnore the following:
sub p_init {}
sub p_default {}
sub p_library {}
sub p_include {}
sub p_public {}
sub p_layout {}


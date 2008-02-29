;# $Id: obsolete.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1995/01/30  14:49:22  ram
;# patch49: random clean-up in &record_obsolete
;#
;# Revision 3.0  1993/08/18  12:10:27  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# Deal with obsolete symbols. They are recorded in the %Obsolete array.
;# Optionally, the obsolete symbols may be remaped onto the new ones (option
;# -o), which enables smooth evolution from 2.0.
;#
# Record obsolete symbols association (new versus old), that is to say for a
# given old symbol, $Obsolete{'old'} = new symbol to be used. A '$' is prepended
# for all shell variables
sub record_obsolete {
	local($_) = @_;
	local(@obsoleted);					# List of obsolete symbols
	local($symbol);						# New symbol which must be used
	local($dollar) = s/^\$// ? '$':'';	# The '$' or a null string
	# Syntax for obsolete symbols specification is
	#    list of symbols (obsolete ones):
	if (/^(\w+)\s*\((.*)\)\s*:$/) {
		$symbol = "$dollar$1";
		@obsoleted = split(' ', $2);		# List of obsolete symbols
	} else {
		if (/^(\w+)\s*\((.*):$/) {
			warn "\"$file\", line $.: final ')' before ':' missing.\n";
			$symbol = "$dollar$1";
			@obsoleted = split(' ', $2);
		} else {
			warn "\"$file\", line $.: syntax error.\n";
			return;
		}
	}
	foreach $val (@obsoleted) {
		$_ = $dollar . $val;
		if (defined $Obsolete{$_}) {
		warn "\"$file\", line $.: '$_' already obsoleted by '$Obsolete{$_}'.\n";
		} else {
			$Obsolete{$_} = $symbol;	# Record (old, new) tuple
		}
	}
}

# Dump obsolete symbols used in file 'Obsolete'. Also write Obsol_h.U and
# Obsol_sh.U to record old versus new mappings if the -o option was used.
sub dump_obsolete {
	unless (-f 'Obsolete') {
		open(OBSOLETE, ">Obsolete") || die "Can't create Obsolete.\n";
	}
	open(OBSOL_H, ">.MT/Obsol_h.U") || die "Can't create .MT/Obsol_h.U.\n";
	open(OBSOL_SH, ">.MT/Obsol_sh.U") || die "Can't create .MT/Obsol_sh.U.\n";
	local($file);						# File where obsolete symbol was found
	local($old);						# Name of this old symbol
	local($new);						# Value of the new symbol to be used
	# Leave a blank line at the top so that anny added ^L will stand on a line
	# by itself (the formatting process adds a ^L when a new page is needed).
	format OBSOLETE_TOP =

              File                 |      Old symbol      |      New symbol
-----------------------------------+----------------------+---------------------
.
	format OBSOLETE =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< | @<<<<<<<<<<<<<<<<<<< | @<<<<<<<<<<<<<<<<<<<
$file,                               $old,                  $new
.
	local(%seen);
	foreach $key (sort keys %ofound) {
		($file, $old, $new) = ($key =~ /^(\S+)\s+(\S+)\s+(\S+)/);
		write(OBSOLETE) unless $file eq 'XXX';
		next unless $opt_o;				# Obsolete mapping done only with -o
		next if $seen{$old}++;			# Already remapped, thank you
		if ($new =~ s/^\$//) {			# We found an obsolete shell symbol
			$old =~ s/^\$//;
			print OBSOL_SH "$old=\"\$$new\"\n";
		} else {						# We found an obsolete C symbol
			print OBSOL_H "#ifdef $new\n";
			print OBSOL_H "#define $old $new\n";
			print OBSOL_H "#endif\n\n";
		}
	}
	close OBSOLETE;
	close OBSOL_H;
	close OBSOL_SH;
	if (-s 'Obsolete') {
		print "*** Obsolete symbols found -- see file 'Obsolete' for a list.\n";
	} else {
		unlink 'Obsolete';
	}
	undef %ofound;				# Not needed any more
}


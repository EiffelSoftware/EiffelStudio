;# $Id: common.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.4  1994/10/29  16:35:01  ram
;# patch36: metaconfig and metaxref ignore ?F: lines from now on
;#
;# Revision 3.0.1.3  1994/05/13  15:29:04  ram
;# patch27: now understands macro definitions in ?H: lines
;#
;# Revision 3.0.1.2  1994/01/24  14:22:54  ram
;# patch16: can now define "internal use only" variables on ?MAKE: lines
;#
;# Revision 3.0.1.1  1993/10/16  13:53:29  ram
;# patch12: added support for ?M: lines and confmagic.h production
;#
;# Revision 3.0  1993/08/18  12:10:19  ram
;# Baseline for dist 3.0 netwide release.
;#
;# The list of all available units is held in @ARGV. We shall parse them and
;# extract the dependencies. A lot of global data structures are filled in
;# during this phase.
;#
;# The following two H tables are used to record each know symbol (i.e. a
;# symbol known by at least one unit), and also how many times this symbol is
;# found in the sources. If an entry for a given key is positive, then the
;# associated symbol (i.e. the key) is wanted and it will be written in the
;# Wanted file.
;#  %shmaster{'$sym'} records how many times '$sym' is found in a .SH file
;#  %cmaster{'SYM'} records how many times 'SYM' is found in a .c file
;#  %cwanted{'SYM'} records the set of necessary shell symbols needed for SYM
;#  %mwanted{'sym'} is set of C symbols needed when sym is found in .c file
;#
;# This data structure records the initializations which are requires at the
;# beginning of a Configure script. The initialization only occurs when the
;# symbol is needed. Those symbols will appear in the produced config.sh file,
;# hence the name of "master" symbols.
;#  @Master records shell configuration symbols which will appear in config.sh
;#
;# The @Cond array records the conditional shell symbols, i.e. those whose
;# value may be defaulted. They will appear in the initialization section of
;# the Configure script with the default value if they are not otherwise used
;# but Configure needs a suitable value internally.
;#  @Cond records symbols which are flagged as conditional in the dependencies
;#  %hasdefault{'sym'} is true when the conditional 'sym' has a default value
;#
;# The %Obsolete array records the obsolecence for units or symbols. The key
;# ends with .U for units, otherwise it is a symbol. Unit's obsolescence is
;# flagged with a ?O: line (the line being the message which will be issued
;# when the unit is used) while symbol obsolecence is indicated on the leading
;# ?C: or ?S: line, between parenthesis. In that case, the value stored is the
;# new symbol which should be used insted.
;#  %Obsolete{'unit.U'} is a message to be printed when obsolete unit is used
;#  %Obsolete{'sym'} is the symbol to be used in place of the obsoleted 'sym'
;#
;# The $dependencies variable is used to record the dependencies extracted
;# from the units (?MAKE: line).
;#
;# During the dependency extraction. some files are produced in the .MT dir.
;#   Init.U records the initialization wanted
;#   Config_h.U records the informations which could go in config.h.SH
;#   Extern.U records the libraries and includes wanted by each symbol
;#
;# This file is shared by both metaconfig and metaxref
;#
# Initialize the extraction process by setting some variables.
# We return a string to be eval to do more customized initializations.
sub init_extraction {
	open(INIT, ">$WD/.MT/Init.U") ||
		die "Can't create .MT/Init.U\n";
	open(CONF_H, ">$WD/.MT/Config_h.U") ||
		die "Can't create .MT/Config_h.U\n";
	open(EXTERN, ">$WD/.MT/Extern.U") ||
		die "Can't create .MT/Extern.U\n";
	open(MAGIC_H, ">$WD/.MT/Magic_h.U") ||
		die "Can't create .MT/Magic_h.U\n";

	$c_symbol = '';				# Current symbol seen in ?C: lines
	$s_symbol = '';				# Current symbol seen in ?S: lines
	$m_symbol = '';				# Current symbol seen in ?M: lines
	$condlist = '';				# List of conditional symbols
	$defined = '';				# List of defined symbols in the unit
	$body = '';					# No procedure to handle body
	$ending = '';				# No procedure to clean-up
}

# End the extraction process
sub end_extraction {
	close EXTERN;			# External dependencies (libraries, includes...)
	close CONF_H;			# C symbol definition template
	close INIT;				# Required initializations
	close MAGIC;			# Magic C symbol redefinition templates

	print $dependencies if $opt_v;	# Print extracted dependencies
}

# Process the ?MAKE: line
sub p_make {
	local($_) = @_;
	local(@ary);					# Locally defined symbols
	local(@dep);					# Dependencies
	if (/^[\w+ ]*:/) {				# Main dependency rule
		s|^\s*||;					# Remove leading spaces
		chop;
		s/:(.*)//;
		@dep = split(' ', $1);			# Dependencies
		@ary = split(' ');				# Locally defined symbols
		foreach $sym (@ary) {
			# Symbols starting with a '+' are meant for internal use only.
			next if $sym =~ s/^\+//;
			# Only sumbols starting with a lowercase letter are to
			# appear in config.sh, excepted the ones listed in Except.
			if ($sym =~ /^[a-z]/ || $Except{$sym}) {
				$shmaster{"\$$sym"} = undef;
				push(@Master,"?$unit:$sym=''\n");	# Initializations
			}
		}
		$condlist = '';				# List of conditional symbols
		local($sym);				# Symbol copy, avoid @dep alteration
		foreach $dep (@dep) {
			if ($dep =~ /^\+[A-Za-z]/) {
				($sym = $dep) =~ s|^\+||;
				$condlist .= "$sym ";
				push(@Cond, $sym) unless $condseen{$sym};
				$condseen{$sym}++;		# Conditionally wanted
			}
		}
		# Append to already existing dependencies. The 'defined' variable
		# is set for &write_out, used to implement ?L: and ?I: canvas. It is
		# reset each time a new unit is parsed.
		# NB: leading '+' for defined symbols (internal use only) have been
		# removed at this point, but conditional dependencies still bear it.
		$defined = join(' ', @ary);		# Symbols defined by this unit
		$dependencies .= $defined . ':' . join(' ', @dep) . "\n";
		$dependencies .= "	-cond $condlist\n" if $condlist;
	} else {
		$dependencies .= $_;		# Building rules
	}
}

# Process the ?O: line
sub p_obsolete {
	local($_) = @_;
	$Obsolete{"$unit.U"} .= $_;		# Message(s) to print if unit is used
}

# Process the ?S: lines
sub p_shell {
	local($_) = @_;
	unless ($s_symbol) {
		if (/^(\w+).*:/) {
			$s_symbol = $1;
			print "  ?S: $s_symbol\n" if $opt_d;
		} else {
			warn "\"$file\", line $.: syntax error in ?S: construct.\n";
			$s_symbol = $unit;
			return;
		}
		# Deal with obsolete symbol list (enclosed between parenthesis)
		&record_obsolete("\$$_") if /\(/;
	}
	m|^\.\s*$| && ($s_symbol = '');		# End of comment
}

# Process the ?C: lines
sub p_c {
	local($_) = @_;
	unless ($c_symbol) {
		if (s/^(\w+)\s*~\s*(\S+)\s*(.*):/$1 $3:/) {
			# The ~ operator aliases the main C symbol to another symbol which
			# is to be used instead for definition in config.h. That is to say,
			# the line '?C:SYM ~ other:' would look for symbol 'other' instead,
			# and the documentation for symbol SYM would only be included in
			# config.h if 'other' were actually wanted.
			$c_symbol = $2;			# Alias for definition in config.h
			print "  ?C: $1 ~ $c_symbol\n" if $opt_d;
		} elsif (/^(\w+).*:/) {
			# Default behaviour. Include in config.h if symbol is needed.
			$c_symbol = $1;
			print "  ?C: $c_symbol\n" if $opt_d;
		} else {
			warn "\"$file\", line $.: syntax error in ?C: construct.\n";
			$c_symbol = $unit;
			return;
		}
		# Deal with obsolete symbol list (enclosed between parenthesis) and
		# make sure that list do not appear in config.h.SH by removing it.
		&record_obsolete("$_") if /\(/;
		s/\s*\(.*\)//;					# Get rid of obsolete symbol list
	}
	s|^(\w+)\s*|?$c_symbol:/* $1| ||						# Start of comment
	(s|^\.\s*$|?$c_symbol: */\n| && ($c_symbol = '', 1)) ||	# End of comment
	s|^(.*)|?$c_symbol: *$1|;								# Middle of comment
	&p_config("$_");					# Add comments to config.h.SH
}

# Process the ?H: lines
sub p_config {
	local($_) = @_;
	local($constraint);					# Constraint to be used for inclusion
	++$old_version if s/^\?%1://;		# Old version
	if (s/^\?(\w+)://) {				# Remove leading '?var:'
		$constraint = $1;				# Constraint is leading '?var'
	} else {
		$constraint = '';				# No constraint
	}
	if (/^#.*\$/) {						# Look only for cpp lines
		if (m|^#\$(\w+)\s+(\w+).*\$(\w+)|) {
			# Case: #$d_var VAR "$var"
			$constraint = $2 unless $constraint;
			print "  ?H: ($constraint) #\$$1 $2 \"\$$3\"\n" if $opt_d;
			$cmaster{$2} = undef;
			$cwanted{$2} = "$1\n$3";
		} elsif (m|^#define\s+(\w+)\((.*)\)\s+\$(\w+)|) {
			# Case: #define VAR(x) $var
			$constraint = $1 unless $constraint;
			print "  ?H: ($constraint) #define $1($2) \$$3\n" if $opt_d;
			$cmaster{$1} = undef;
			$cwanted{$1} = $3;
		} elsif (m|^#\$define\s+(\w+)|) {
			# Case: #$define VAR
			$constraint = $1 unless $constraint;
			print "  ?H: ($constraint) #define $1\n" if $opt_d;
			$cmaster{$1} = undef;
			$cwanted{$1} = "define\n$unit";
		} elsif (m|^#\$(\w+)\s+(\w+)|) {
			# Case: #$d_var VAR
			$constraint = $2 unless $constraint;
			print "  ?H: ($constraint) #\$$1 $2\n" if $opt_d;
			$cmaster{$2} = undef;
			$cwanted{$2} = $1;
		} elsif (m|^#define\s+(\w+).*\$(\w+)|) {
			# Case: #define VAR "$var"
			$constraint = $1 unless $constraint;
			print "  ?H: ($constraint) #define $1 \"\$$2\"\n" if $opt_d;
			$cmaster{$1} = undef;
			$cwanted{$1} = $2;
		} else {
			$constraint = $unit unless $constraint;
			print "  ?H: ($constraint) $_" if $opt_d;
		}
	} else {
		print "  ?H: ($constraint) $_" if $opt_d;
	}
	# If not a single ?H:. line, add the leading constraint
	s/^\.// || s/^/?$constraint:/;
	print CONF_H;
}

# Process the ?M: lines
sub p_magic {
	local($_) = @_;
	unless ($m_symbol) {
		if (/^(\w+):\s*([\w\s]*)\n$/) {
			# A '?M:sym:' line implies a '?W:%<:sym' since we'll need to know
			# about the wantedness of sym later on when building confmagic.h.
			# Buf is sym is wanted, then the C symbol dependencies have to
			# be triggered. That is done by introducing sym in the mwanted
			# array, known by the Wanted file construction process...
			$m_symbol = $1;
			print "  ?M: $m_symbol\n" if $opt_d;
			$mwanted{$m_symbol} = $2;		# Record C dependencies
			&p_wanted("$unit:$m_symbol");	# Build fake ?W: line
		} else {
			warn "\"$file\", line $.: syntax error in ?M: construct.\n";
		}
		return;
	}
	(s/^\.\s*$/?$m_symbol:\n/ && ($m_symbol = '', 1)) ||	# End of block
	s/^/?$m_symbol:/;
	print MAGIC_H;					# Definition goes to confmagic.h
	print "  ?M: $_" if $opt_d;
}

sub p_ignore {}		# Ignore comment line
sub p_lint {}		# Ignore lint directives
sub p_visible {}	# No visible checking in metaconfig
sub p_temp {}		# No temporary variable control
sub p_file {}		# Ignore produced file directives (for now)


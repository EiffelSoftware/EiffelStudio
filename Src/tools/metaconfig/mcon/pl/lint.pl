;# $Id: lint.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.10  1997/02/28  16:31:53  ram
;# patch61: added support for ?F: lines to monitor file usage
;# patch61: now honours "create" and "empty" lint directives
;#
;# Revision 3.0.1.9  1995/09/25  09:19:15  ram
;# patch59: new ?Y: directive to change unit layout
;#
;# Revision 3.0.1.8  1995/07/25  14:19:47  ram
;# patch56: will now check : comments line for potential danger
;#
;# Revision 3.0.1.7  1994/10/29  16:36:14  ram
;# patch36: now extensively checks created files thanks to new ?F: lines
;#
;# Revision 3.0.1.6  1994/05/13  15:29:09  ram
;# patch27: now understands macro definitions in ?H: lines
;#
;# Revision 3.0.1.5  1994/05/06  15:27:48  ram
;# patch23: now warns for units ending with non-blank line
;# patch23: warn for units where last line is not new-line terminated
;#
;# Revision 3.0.1.4  1994/01/24  14:28:40  ram
;# patch16: now knows about "internal use only" variables on ?MAKE: lines
;# patch16: now suppress "read-only var set" message when change hint
;#
;# Revision 3.0.1.3  1993/11/10  17:39:39  ram
;# patch14: now spots stale ?M: dependencies
;#
;# Revision 3.0.1.2  1993/10/16  13:55:26  ram
;# patch12: now checks ?M: lines also
;#
;# Revision 3.0.1.1  1993/08/25  14:03:40  ram
;# patch6: now correctly signals conditional dependencies with no default
;#
;# Revision 3.0  1993/08/18  12:10:25  ram
;# Baseline for dist 3.0 netwide release.
;#
;# The list of all available units is held in @ARGV. We shall parse them and
;# extract the dependencies. A lot of global data structures are filled in
;# during this phase.
;#
# Initialize the extraction process by setting some variables.
# We return a string to be eval'ed to do more customized initializations.
sub init_extraction {
	$c_symbol = '';				# Current symbol seen in ?C: lines
	$s_symbol = '';				# Current symbol seen in ?S: lines
	$m_symbol = '';				# Current symbol seen in ?M: lines
	$last_interpreted = 0;		# True when last line was an '@' one
	%csym = ();					# C symbols described
	%ssym = ();					# Shell symbols described
	%hcsym = ();				# C symbols used by ?H: lines
	%hssym = ();				# Shell symbols used by ?H: lines
	%msym = ();					# Magic symbols defined by ?M: lines
	%mdep = ();					# C symbol dependencies introduced by ?M:
	%symset = ();				# Records all the shell symbol set
	%symused = ();				# Records all the shell symbol used
	%tempseen = ();				# Temporary shell variable seen
	%fileseen = ();				# Produced files seen
	%fileused = ();				# Files used, by unit (private UU files)
	%filemisused = ();			# Files not used as ./file or ...UU/file
	%filetmp = ();				# Local temporary files in ?F: directives
	%filesetin = ();			# Lists units defining a temporary file
	%filecreated = ();			# Records files created in this unit
	%prodfile = ();				# Unit where a given file is said to be created
	%defseen = ();				# Symbol defintions claimed
	%lintseen = ();				# Symbols declared known by a ?LINT: line
	%lintchange = ();			# Symbols declared changed by a ?LINT: line
	%lintuse = ();				# Symbols declared used by unit
	%lintextern = ();			# Symbols known to be externally defined
	%lintcreated = ();			# Files declared as created by a ?LINT: line
	%condsym = ();				# Records all the conditional symbols
	%condseen = ();				# Records conditional dependencies
	%depseen = ();				# Records full dependencies
	%shvisible = ();			# Records units making a symbol visible
	%shspecial = ();			# Records special units listed as wanted
	%shdepend = ();				# Records units listed in one's dependency list
	%shmaster = ();				# List of units defining a shell symbol
	%cmaster = ();				# List of units defining a C symbol
	%symdep = ();				# Records units where symbol is a dependency
	@make = ();					# Records make dependency lines
	$body = 'p_body';			# Procedure to handle body
	$ending = 'p_end';			# Called at the end of each unit
}

# End the extraction process
sub end_extraction {
}

# Process the ?MAKE: line
sub p_make {
	local($_) = @_;
	local(@ary);					# Locally defined symbols
	local(@dep);					# Dependencies
	local($where) = "\"$file\", line $. (?MAKE:)";
	return unless /^[\w+ ]*:/;		# We only want the main dependency rule
	warn "$where: ignoring duplicate dependency listing line.\n"
		if $makeseen{$unit}++;
	return if $makeseen{$unit} > 1;
	undef %condseen;				# Reset those once for every unit
	undef %depseen;					# (assuming there is only one depend line)
	undef %defseen;
	undef %tempseen;
	undef %symset;
	undef %symused;
	undef %csym;
	undef %ssym;
	undef %hcsym;
	undef %hssym;
	undef %lintseen;
	undef %lintchange;
	undef %lintextern;
	undef %lintcreated;
	undef %fileseen;
	undef %filetmp;
	undef %filecreated;
	s|^\s*||;						# Remove leading spaces
	chop;
	s/:(.*)//;
	@dep = split(' ', $1);			# Dependencies
	@ary = split(' ');				# Locally defined symbols
	local($nowarn);					# True when +Special is seen
	foreach $sym (@ary) {
		# Ignore "internal use only" symbols as far as metalint goes.
		# Actually, we record the presence of a '+' in front of a special
		# unit name and use that as a hint to suppress the presence of that
		# special unit in the defined symbol section.
		$nowarn = ($sym =~ s/^\+//);

		# We record for each shell symbol the list of units which claim to make
		# it, so as to report duplicates.
		if ($sym =~ /^[_a-z]/ || $Except{$sym}) {
			$shmaster{"\$$sym"} .= "$unit ";
			++$defseen{$sym};
		} else {
			warn "$where: special unit '$sym' should not be listed as made.\n"
				unless $sym eq $unit || $nowarn;
		}
	}
	# Record dependencies for later perusal
	push(@make, join(' ', @ary) . ':' . join(' ', @dep));
	foreach $sym (@dep) {
		if ($sym =~ /^\+[_A-Za-z]/) {
			$sym =~ s|^\+||;
			++$condseen{$sym};		# Conditional symbol wanted
			++$condsym{$sym};		# %condsym has a greater lifetime
		} else {
			++$depseen{$sym};		# Full dependency
		}

		# Each 'wanted' special unit (i.e. one starting with a capital letter)
		# is remembered, so as to prevent exported symbols from being reported
		# as "undefined". For instance, Myread exports $dflt, $ans and $rp.
		$shspecial{$unit} .= "$sym " if substr($sym, 0, 1) =~ /^[A-Z]/;

		# Record all known dependencies (special or not) for this unit
		$shdepend{$unit} .= "$sym ";

		# Remember where wanted symbol is defined, so that we can report
		# stale dependencies later on (i.e. dependencies which refer to non-
		# existent symbols).
		$symdep{$sym} .= "$unit ";	# This symbol is wanted here
	}
	# Make sure we do not want a symbol twice, nor do we want it once as a full
	# dependency and once as a conditional dependency.
	foreach $sym (@dep) {
		if ($sym =~ /^\+[_A-Za-z]/) {
			$sym =~ s|^\+||;
			warn "$where: '+$sym' is listed $condseen{$sym} times.\n"
				if $condseen{$sym} > 1;
			$condseen{$sym} = 1 if $condseen{$sym};	# Avoid multiple messages
		} else {
			warn "$where: '$sym' is listed $depseen{$sym} times.\n"
				if $depseen{$sym} > 1;
			$depseen{$sym} = 1 if $depseen{$sym};	# Avoid multiple messages
		}
		warn "$where: '$sym' listed as both conditional and full dependency.\n"
			if $condseen{$sym} && $depseen{$sym};
	}
	# Make sure every unit "inherits" from the symbols exported by 'Init'.
	$shspecial{$unit} .= 'Init ' unless $shspecial{$unit} =~ /Init\b/;
}

# Process the ?O: line
sub p_obsolete {
	local($_) = @_;
	chop;
	$Obsolete{"$unit.U"} = $_;		# Message to print if unit is used
}

# Process the ?S: lines
sub p_shell {
	local($_) = @_;
	local($where) = "\"$file\", line $. (?S:)";
	if (/^(\w+)\s*(\(.*\))*\s*:/) {
		&check_last_declaration;
		$s_symbol = $1;
		print "  ?S: $s_symbol\n" if $opt_d;
		# Make sure we do not define symbol twice and that the symbol is indeed
		# listed in the ?MAKE: line.
		warn "$where: duplicate description for variable '\$$s_symbol'.\n"
			if $ssym{$s_symbol}++;
		warn "$where: variable '\$$s_symbol' is not listed on ?MAKE: line.\n"
			unless $defseen{$s_symbol} || $lintseen{$s_symbol};
		# Deal with obsolete symbol list (enclosed between parenthesis)
		&record_obsolete("\$$_") if /\(/;
	} else {
		unless ($s_symbol) {
			warn "$where: syntax error in ?S: construct.\n";
			return;
		}
	}

	m|^\.\s*$| && ($s_symbol = '');		# End of comment
}

# Process the ?C: lines
sub p_c {
	local($_) = @_;
	local($where) = "\"$file\", line $. (?C:)";
	if (s/^(\w+)\s*~\s*(\S+)\s*(.*):/$1 $3:/) {
		&check_last_declaration;
		$c_symbol = $2;					# Alias for definition in config.h
		# Record symbol definition for further duplicate spotting
		$cmaster{$1} .= "$unit " unless $csym{$1};
		print "  ?C: $1 ~ $c_symbol\n" if $opt_d;
		# Make sure we do not define symbol twice
		warn "$where: duplicate description for symbol '$1'.\n"
			if $csym{$1}++;
		# Deal with obsolete symbol list (enclosed between parenthesis)
		&record_obsolete("$_") if /\(/;
	} elsif (/^(\w+)\s*(\(.*\))*\s*:/) {
		&check_last_declaration;
		$c_symbol = $1;
		# Record symbol definition for further duplicate spotting
		$cmaster{$c_symbol} .= "$unit " unless $csym{$c_symbol};
		print "  ?C: $c_symbol\n" if $opt_d;
		# Make sure we do not define symbol twice
		warn "$where: duplicate description for symbol '$c_symbol'.\n"
			if $csym{$c_symbol}++;
		# Deal with obsolete symbol list (enclosed between parenthesis)
		&record_obsolete("$_") if /\(/;
	} else {
		unless ($c_symbol) {
			warn "$where: syntax error in ?C: construct.\n";
			return;
		}
	}

	s|^(\w+)|?$c_symbol:/* $1| ||							# Start of comment
	(s|^\.\s*$|?$c_symbol: */\n| && ($c_symbol = '', 1)) ||	# End of comment
	s|^(.*)|?$c_symbol: *$1|;								# Middle of comment
	&p_config("$_");					# Add comments to config.h.SH
}

# Process the ?H: lines
sub p_config {
	local($_) = @_;
	local($where) = "\"$file\", line $. (?H)" unless $where;
	s/^\?(\w+)://;						# Remove leading '?var:'
	return unless /^#/;					# Look only for cpp lines
	if (m|^#\$(\w+)\s+(\w+).*\$(\w+)|) {
		# Case: #$d_var VAR "$var"
		warn "$where: symbol '$2' was already defined.\n" if $hcsym{$2}++;
		&check_definition("$1");
		&check_definition("$3");
	} elsif (m|^#define\s+(\w+)\((.*)\)\s+\$(\w+)|) {
		# Case: #define VAR(x) $var
		warn "$where: symbol '$1' was already defined.\n" if $hcsym{$1}++;
		&check_definition("$3");
	} elsif (m|^#\$define\s+(\w+)|) {
		# Case: #$define VAR
		warn "$where: symbol '$1' was already defined.\n" if $hcsym{$1}++;
	} elsif (m|^#\$(\w+)\s+(\w+)|) {
		# Case: #$d_var VAR
		warn "$where: symbol '$2' was already defined.\n" if $hcsym{$2}++;
		&check_definition("$1");
	} elsif (m|^#define\s+(\w+).*\$(\w+)|) {
		# Case: #define VAR "$var"
		warn "$where: symbol '$1' was already defined.\n" if $hcsym{$1}++;
		&check_definition("$2");
	} elsif (m|^#define\s+(\w+)|) {
		# Case: #define VAR
		$hcsym{$1}++;			# Multiple occurrences may be legitimate
	}
}

# Process the ?M: lines
sub p_magic {
	local($_) = @_;
	local($where) = "\"$file\", line $. (?M)";
	if (/^(\w+):\s*([\w\s]*)\n$/) {
		&check_last_declaration;
		$m_symbol = $1;
		$msym{$1} = "$unit";	# p_wanted ensure we do not define symbol twice
		$mdep{$1} = $2;			# Save C symbol dependencies
		&p_wanted("$unit:$m_symbol");
	} else {
		unless ($m_symbol) {
			warn "$where: syntax error in ?M: construct.\n";
			return;
		}
	}
	m|^\.\s*$| && ($m_symbol = '');		# End of comment
}

# Process the ?INIT: lines
sub p_init {
	local($where) = "\"$file\", line $. (?INIT)";
	&p_body;		# Pass it along as a body line (leading ?INIT: removed)
}

# Process the ?D: lines
sub p_default {
	local($_) = @_;
	local($where) = "\"$file\", line $. (?D)";
	local($sym) = /^(\w+)=/;
	$hasdefault{$sym}++;
	&p_body;		# Pass it along as a body line (leading ?D: removed)
}

# Process the ?V: lines
sub p_visible {
	# A visible symbol can freely be manipulated by any unit which includes the
	# current unit in its dependencies. Symbols before ':' may be only used for
	# reading while symbols after ':' may be used for both reading and writing.
	# The array %shvisible records symbols as keys. Read-only symbols have a
	# leading '$' while read-write symbols are recorded as-is.
	local($where) = "\"$file\", line $. (?V)";
	unless (substr($unit, 0, 1) =~ /^[A-Z]/) {
		warn "$where: visible declaration in non-special unit ignored.\n";
		return;
	}
	local($read_only) = $_[0] =~ /^([^:]*):?/;
	local($read_write) = $_[0] =~ /:(.*)/;
	local(@rsym) = split(' ', $read_only);
	local(@rwsym) = split(' ', $read_write);
	local($w);
	foreach (@rsym) {		# Read only symbols
		warn "$where: wanted variable '\$$_' made visible.\n" if &wanted($_);
		warn "$where: defined variable '\$$_' made visible.\n"
			if &defined($_) && !$lintseen{$_};
		$w = $shvisible{"\$$_"};
		warn "$where: variable '\$$_' already made visible by unit $w.\n" if $w;
		$w = $shvisible{$_};
		warn "$where: variable '\$$_' already read-write visible in $w.\n" if $w;
		$shvisible{"\$$_"} = $unit unless $w;
	}
	foreach (@rwsym) {		# Read/write symbols
		warn "$where: wanted variable '\$$_' made visible.\n" if &wanted($_);
		warn "$where: defined variable '\$$_' made visible.\n"
			if &defined($_) && !$lintseen{$_};
		$w = $shvisible{$_};
		warn "$where: variable '\$$_' already made visible by unit $w.\n" if $w;
		$w = $shvisible{"\$$_"};
		warn "$where: variable '\$$_' already read-only visible in $w.\n" if $w;
		$shvisible{$_} = $unit unless $w;
	}
}

# Process the ?W: lines
sub p_wanted {
	# Somehow, we should check that none of the symbols to activate are stale
	# ones, i.e. they all finally resolve to some known target -- FIXME
	local($active) = $_[0] =~ /^([^:]*):/;		# Symbols to activate
	local($look_symbols) = $_[0] =~ /:(.*)/;	# When those are used
	local(@symbols) = split(' ', $look_symbols);
	local($where) = "\"$file\", line $. (?W)" unless $where;
	# A "?W:symbol" line asks metaconfig to define 'symbol' in the wanted file
	# as a C target iff that word is found within the sources. This is mainly
	# intended for the built-in interpreter to check for definedness.
	local($w);
	foreach (@symbols) {
		warn "$where: variable '\$$_' already wanted.\n" if &wanted($_);
		warn "$where: variable '\$$_' also locally defined.\n" if &defined($_);
		$w = $cwanted{$_};
		if ($msym{$_} ne '') {
			warn "$where: symbol '$_' already listed on a ?M: line in '$w'.\n"
				if $w;
		} else {
		warn "$where: variable '\$$_' already listed on a ?W: line in '$w'.\n"
			if $w;
		}
		$cwanted{$_} = $unit unless $w;
	}
}

# Process the ?Y: lines
sub p_layout {
	local($_) = @_;
	chop;
	local($where) = "\"$file\", line $. (?Y)";
	s/^\s+//;
	tr/A-Z/a-z/;			# Layouts are record in lowercase
	warn "$where: unknown layout directive '$_'.\n"
		unless defined $Lcmp{$_};
}

# Process the ?P: lines
sub p_public {
	# FIXME
}

# Process the ?L: lines
sub p_library {
	# There should not be any '-l' in front of the library name
	# FIXME
}

# Process the ?I: lines
sub p_include {
	# FIXME
}

# Process the ?T: lines
sub p_temp {
	local($_) = @_;
	local(@sym) = split(' ', $_);
	local($where) = "\"$file\", line $. (?T:)";
	foreach $sym (@sym) {
		warn "$where: temporary symbol '\$$sym' multiply declared.\n"
			if $tempseen{$sym}++ == 1;
		$tempmaster{$sym} .= "$unit " if $tempseen{$sym} == 1;
	}
}

# Process the ?F: lines
sub p_file {
	local($_) = @_;
	local(@files) = split(' ', $_);
	local($where) = "\"$file\", line $. (?F:)";
	local($uufile);					# Name of file produced in the UU directory
	local($tmpfile);				# Name of a temporary file
	# We care only about UU files, i.e. files produced in the UU directory
	# and which are identified by the convention ./filename. Files !filename
	# are not produced, i.e. they are temporary or externally provided.
	# The %prodfile table records all the files produced, so we may detect
	# inconsistencies between units, while %filemaster records the (first) unit
	# defining a given UU file to make sure that (special) unit is named in the
	# dependency line when that UU file. Duplicates will be caught in the
	# sanity check phase thanks to %prodfile.
	# Temporary files are recorded in %filesetin, so that we may later compare
	# the list with the UU files to detect possible overwrites.
	foreach $file (@files) {
		warn "$where: produced file '$file' multiply declared.\n"
			if $fileseen{$file}++ == 1;
		if (($tmpfile = $file) =~ s/^!//) {
			$filetmp{$tmpfile}++;
			$filesetin{$tmpfile} .= "$unit " if $fileseen{$file} == 1;
			next;					# Is not a UU file for sure, so skip
		}
		$prodfile{$file} .= "$unit " if $fileseen{$file} == 1;
		($uufile = $file) =~ s|^\./(\S+)$|$1|;
		next if $file eq $uufile;	# Don't care about non-UU files
		unless (substr($unit, 0, 1) =~ /^[A-Z]/ || $lintcreated{$uufile}) {
			warn "$where: UU file '$uufile' in non-special unit ignored.\n";
			next;
		}
		$filemaster{$uufile} = $unit unless defined $filemaster{$uufile};
		$filecreated{$uufile} = 'a';	# Will be automagically incremented
	}
}

# Process the ?LINT: lines
sub p_lint {
	local($_) = @_;
	local(@sym);
	s/^\s+//;						# Strip leading spaces
	if (s/^set//) {					# Listed variables are set
		@sym = split(' ', $_);
		foreach (@sym) {
			$symset{$_}++;			# Shell variable set
		}
	} elsif (s/^desc\w+//) {		# Listed shell variables are described
		@sym = split(' ', $_);
		foreach (@sym) {
			$ssym{$_}++;			# Shell variable described
		}
	} elsif (s/^creat\w+//) {		# Listed created files in regular units
		@sym = split(' ', $_);
		foreach (@sym) {
			$lintcreated{$_}++;		# Persistent UU file created
		}
	} elsif (s/^known//) {			# Listed C variables are described
		@sym = split(' ', $_);
		foreach (@sym) {
			$csym{$_}++;			# C symbol described
		}
	} elsif (s/^change//) {			# Shell variable ok to be changed
		@sym = split(' ', $_);
		foreach (@sym) {
			$lintchange{$_}++;		# Do not complain if changed
		}
	} elsif (s/^extern//) {			# Variables known to be externally defined
		@sym = split(' ', $_);
		foreach (@sym) {
			$lintextern{$_}++;		# Do not complain if used in a ?H: line
		}
	} elsif (s/^use//) {			# Variables declared as used by unit
		@sym = split(' ', $_);
		foreach (@sym) {
			$lintuse{$_}++;			# Do not complain if on ?MAKE and not used
		}
	} elsif (s/^def\w+//) {			# Listed variables are defined
		@sym = split(' ', $_);
		foreach (@sym) {
			$lintseen{$_}++;		# Shell variable defined in this unit
		}
	} elsif (m/^empty/) {			# Empty unit file
		$lintempty{$unit}++;
	} else {
		local($where) = "\"$file\", line $." unless $where;
		local($word) = /^(\w+)/;
		warn "$where: unknown LINT request '$word' ignored.\n";
	}
}

# Process the body of the unit
sub p_body {
	return unless $makeseen{$unit};
	local($_) = @_;
	local($where) = "\"$file\", line $." unless $where;
	# Ensure there is no control line in the body of the unit
	local($control) = /^\?([\w\-]+):/;
	local($known) = $control ? $Depend{$control} : "";
	warn "$where: control sequence '?$control:' ignored within body.\n"
		if $known && !/^\?X:|^\?LINT:/;
	if (s/^\?LINT://) {				# ?LINT directives allowed within body
		$_ .= &complete_line(FILE) if s/\\\s*$//;
		&p_lint($_);
	}
	return if $known;
	# Ingnore interpreted lines and their continuations
	if ($last_interpreted) {
		return if /\\$/;			# Still part of the interpreted line
		$last_interpreted = 0;		# End of interpreted lines
		return;						# This line was the last interpreted
	}
	# Look for interpreted lines and ignore them
	if (/^@/) {
		$last_interpreted = /\\$/;	# Set flag if line is continued
		return;						# And skip this line
	}
	s/^\s+//;						# Remove leading spaces
	# Detect shell ':' "comment" lines, and perform sanity checks on them...
	# Also spot any of '<>|&;' since those will have their shell behaviour
	# behaviour
	if (s/^:\s+//) {
		s/<\$?\w+>//g;				# Remove valid <$var> escapes or old <VAR>
		warn "$where: meaningful shell character '$1' in comment line.\n"
			while s/([<>&\|;]+)//g;
		require 'shellwords.pl';
		eval { &shellwords($_) };
		return unless $@;			# Ignore comment, no quoting problem
		local($what) = '';
		$what = 'double' if $@ =~ /\bdouble\b/;
		$what = 'single' if $@ =~ /\bsingle\b/;
		warn "$where: unmatched $what quote in comment line.\n" if $what;
		warn "$where: $@" unless $what;
		return;
	}

	# From now on, do all substitutes with ':' since it would be dangerous
	# to remove things plain and simple. It could yields false matches
	# afterwards...

	# Record any attempt made to set a shell variable
	local($sym);
	while (s/(\w+)=/:/) {
		$sym = $1;
		next if $sym =~ /^\d+/;		# Ignore $1 and friends
		$symset{$sym}++;			# Shell variable set
		# Not part of a $cc -DWHATEVER line and not made nor temporary
		unless ($sym =~ /^D/ || &defined($sym)) {
			if (&wanted($sym)) {
				warn "$where: variable '\$$sym' is changed.\n"
					unless $lintchange{$sym};
			} else {
				# Record that the variable is set but not listed locally.
				$shset{$unit} .= "$sym " unless
					$shset{$unit} =~ /\b$sym\b/ || $lintchange{$sym};
			}
		}
	}
	# Now look at the shell variables used: can be $var or ${var}
	local($var);
	local($line) = $_;
	while (s/\$\{?(\w+)\}?/:/) {
		$var = $1;
		next if $var =~ /^\d+/;		# Ignore $1 and friends
		# Record variable as undeclared but do not issue a message right now.
		# That variable could be exported via ?V: (as $dflt in Myread) or be
		# defined by a special unit (like $inlibc by unit Inlibc).
		$shunknown{$unit} .= "$var " unless
			$lintextern{$var} || &declared($var) ||
			$shunknown{$unit} =~ /\b$var\b/;
		$shused{$unit} .= "\$$var " unless $shused{$unit} =~ /\$$var\b/;
	}
	# Now look at private files used by the unit (./file or ..../UU/file)
	# We look at things like '. ./myread' and `./loc ...` only.
	local($file);
	$_ = $line;
	while (
		s!(\.\s+|`\s*)(\S*UU|\.)/([^\$/`\s;]+)\s*!! ||
		s!(`\s*\$?)cat\s+(\./)?([^\$/`\s;]+)\s*`!! ||
		s!if(\s+)(\./)([^\$/`\s;]+)\s*!!
	) {
		$file = $3;
		# Found some ". ./file" or `./file` execution, `$cat file`, "if prog"...
		# Record file as used. Later on, we will make sure we had the right
		# to use that file: either we are in the unit that defines it, or we
		# include the unit that creates it in our dependencies, relying on ?F:.
		$fileused{$unit} .= "$file " unless
			$filetmp{$file} || $fileused{$unit} =~ /\b$file\b/;
		# Mark temporary file as being used, to spot useless local declarations
		$filetmp{$file} .= ' used'
			if defined $filetmp{$file} && $filetmp{$file} !~ /\bused/;
	}
	# Try to detect things like . myread or `loc` to warn that they
	# should rather use . ./myread and `./loc`. Also things like 'if prog',
	# or usage in conditional expressions such as || and &&. Be sure the file
	# name is always in $2...
	while (
		s!(\.\s+|`\s*)([^\$/`\s;]+)\s*!:!	||	# . myread or `loc`
		s!(if|\|\||&&)\s+([^\$/`\s;]+)\s*!:!	# if prog, || prog, && prog
	) {
		$file = $2;
		$filemisused{$unit} .= "$file " unless
			$filetmp{$file} || $filemisused{$unit} =~ /\b$file\b/;
		# Temporary files should be used with ./ anyway
		$filetmp{$file} .= ' misused'
			if defined $filetmp{$file} && $filetmp{$file} !~ /\bmisused/;
	}
	# Locate file creation, >>file or >file
	while (s!>>?\s*([^\$/`\s;]+)\s*!:!) {
		$file = $1;
		next if $file =~ /&\d+/;	# skip >&4 and friends
		$filecreated{$file}++;
	}
}

# Called at the end of each unit
sub p_end {
	local($last) = @_;				# Last processed line
	local($where) = "\"$file\"";
	unless ($makeseen{$unit}) {
		warn "$where: no ?MAKE: line describing dependencies.\n"
			unless $lintempty{$unit};
		return;
	}

	# Each unit should end with a blank line. Unfortunately, some units
	# may also end with an '@end' request and have the blank line above it.
	# Currently, we do not have enough information to correctly diagnose
	# whether it is valid or not so just skip it.
	# Same thing for U/Obsol_sh.U which ends with a shell comment.

	warn "$where: not ending with a blank line.\n" unless
		$last =~ /^\s*$/ || $last =~ /^\@end/ || $last =~ /^#|\?/;

	# For EMACS users. It would be fatal to the Configure script...
	warn "$where: last line not ending with a new-line character.\n"
		unless $last =~ /\n$/;

	# Make sure every shell symbol described in ?MAKE had a description
	foreach $sym (sort keys %defseen) {
		warn "$where: symbol '\$$sym' was not described.\n"
			unless $ssym{$sym};
	}
	# Ensure all the C symbols defined by ?H: lines have a description
	foreach $sym (sort keys %hcsym) {
		warn "$where: C symbol '$sym' was not described.\n"
			unless $csym{$sym};
	}
	# Ensure all the C symbols described by ?C: lines are defined in ?H:
	foreach $sym (sort keys %csym) {
		warn "$where: C symbol '$sym' was not defined by any ?H: line.\n"
			unless $hcsym{$sym};
	}
	# Make sure each defined symbol was set, unless it starts with an
	# upper-case letter in which case it is not a "true" shell symbol.
	# I don't care about the special symbols defined in %Except as I know
	# they are handled correctly.
	foreach $sym (sort keys %defseen) {
		warn "$where: variable '\$$sym' should have been set.\n"
			unless $symset{$sym} || substr($sym, 0, 1) =~ /^[A-Z]/;
	}
	# Make sure every non-special unit declared as wanted is indeed needed
	foreach $sym (sort keys %depseen) {
		warn "$where: unused dependency variable '\$$sym'.\n" unless
			$shused{$unit} =~ /\$$sym\b/ || substr($sym, 0, 1) =~ /^[A-Z]/ ||
			$lintchange{$sym} || $lintuse{$sym};
	}
	# Idem for conditionally wanted symbols
	foreach $sym (sort keys %condseen) {
		warn "$where: unused conditional variable '\$$sym'.\n" unless
			$shused{$unit} =~ /\$$sym\b/ || substr($sym, 0, 1) =~ /^[A-Z]/ ||
			$lintchange{$sym} || $lintuse{$sym};
	}
	# Idem for temporary symbols
	foreach $sym (sort keys %tempseen) {
		warn "$where: unused temporary variable '\$$sym'.\n" unless
			$shused{$unit} =~ /\$$sym\b/ || $symset{$sym} || $lintuse{$sym};
	}
	# Idem for local files
	foreach $file (sort keys %filetmp) {
		warn "$where: mis-used temporary file '$file'.\n" if
			$filetmp{$file} =~ /\bmisused/;
		warn "$where: unused temporary file '$file'.\n" unless
			$filetmp{$file} =~ /\bused/ || $filetmp{$file} =~ /\bmisused/;
	}
	# Make sure each private file listed as created on ?F: is really created.
	# When found, a private UU file is entered in the %filecreated array
	# with value 'a'. Each time a file creation occurs in the unit, an
	# increment is done on that value. Since 'a'++ -> 'b', a numeric value
	# in %filecreated means a non-local file, which is skipped. An 'a' means
	# the file was not created...
	local($value);
	foreach $file (sort keys %filecreated) {
		$value = $filecreated{$file};
		next if $value > 0;		# Skip non UU-files.
		warn "$where: file '$file' was not created.\n" if $value eq 'a';
	}
}

# An unknown control line sequence was found (held in $proc)
sub p_unknown {
	warn "\"$file\", line $.: unknown control sequence '?$proc:'.\n";
}

# Run sanity checks, to make sure every conditional symbol has a suitable
# default value. Also ensure every symbol was defined once.
sub sanity_checks {
	print "Sanity checks...\n";
	local($key, $value);
	local($w);
	local(%message);		# Record messages on a per-unit basis
	local(%said);			# Avoid duplicate messages
	# Warn about symbols ever used in conditional dependency with no default
	while (($key, $value) = each(%condsym)) {
		unless ($hasdefault{$key}) {
			$w = (split(' ', $shmaster{"\$$key"}))[0];
			$message{$w} .= "#$key ";
		}
	}
	# Warn about any undeclared variables. They are all listed in %shunknown,
	# being the values while the unit where they appear is the key. If the
	# symbol is defined by any of the special units included or made visible,
	# then no warning is issued.
	local($defined);		# True if symbol is defined in one unit
	local($where);			# List of units where symbol is defined
	local($myself);			# The name of the current unit if itself special
	local($visible);		# Symbol made visible via a ?V: line
	foreach $unit (sort keys %shunknown) {
		foreach $sym (split(' ', $shunknown{$unit})) {
			$defined = 0;
			$where = $shmaster{"\$$sym"};
			$defined = 1 if $tempmaster{"\$$sym"} =~ /$unit\b/;
			$myself = substr($unit, 0, 1) =~ /^[A-Z]/ ? $unit : '';
			# Symbol has to be either defined within one of the special units
			# listed in the dependencies or exported via a ?V: line.
			unless ($defined) {
				$defined = &visible($sym, $unit);
				$spneeded{$unit}++ if $defined;
			}
			$message{$unit} .= "\$$sym " unless $defined;
		}
	}

	# Warn about any undeclared files. Files used in one unit are all within
	# the %fileused table, indexed by unit. If a file is used, it must either
	# be in the unit that declared it (relying on %filemaster for that) or
	# the unit listed in %filemaster must be part of our dependency.
	%said = ();
	foreach $unit (sort keys %fileused) {
		foreach $file (split(' ', $fileused{$unit})) {
			$defined = 0;
			$where = $filemaster{$file};		# Where file is created
			$defined = 1 if $unit eq $where;	# We're in the unit defining it
			# Private UU files may be only be created by special units
			foreach $special (split(' ', $shspecial{$unit})) {
				last if $defined;
				$defined = 1 if $where eq $special;
			}
			# Exceptions to above rule possible via a ?LINT:create hint,
			# so parse all known dependencies for the unit...
			foreach $depend (split(' ', $shdepend{$unit})) {
				last if $defined;
				$defined = 1 if $where eq $depend;
			}
			$message{$unit} .= "\@$file " unless
				$defined || $said{"$unit/$file"}++;	# Unknown file
		}
	}
	undef %fileused;

	# Warn about any misused files, kept in %filemisused
	foreach $unit (sort keys %filemisused) {
		foreach $file (split(' ', $filemisused{$unit})) {
			next unless defined $filemaster{$file};	# Skip non UU-files
			$message{$unit} .= "\@\@$file ";		# Misused file
		}
	}
	undef %filemisused;

	# Warn about temporary files which could be created and inadvertently
	# override a private UU file (listed in %filemaster).
	foreach $tmpfile (keys %filesetin) {
		next unless defined $filemaster{$tmpfile};
		$where = $filemaster{$tmpfile};
		foreach $unit (split(' ', $filesetin{$tmpfile})) {
			$message{$unit} .= "\@\@\@$where:$tmpfile ";
		}
	}
	undef %filesetin;

	# Warn about any set variable which was not listed.
	foreach $unit (sort keys %shset) {
		symbol: foreach $sym (split(' ', $shset{$unit})) {
			next if $shvisible{$sym};
			$defined = 0;
			# Symbol has to be either defined within one of the special units
			# listed in the dependencies or exported read-write via a ?V: line.
			# If symbol is exported read-only, report the attempt to set it.
			$where = $shmaster{"\$$sym"};
			study $where;
			foreach $special (split(' ', $shspecial{$unit})) {
				$defined = 1 if $where =~ /\b$special\b/;
				last if $defined;
			}
			$visible = 0;
			$defined = $visible = &visible($sym, $unit) unless $defined;
			if ($visible && $shvisible{"\$$sym"} ne '') {
				# We are allowed to set a read-only symbol in the unit which
				# declared it...
				next symbol if $shvisible{"\$$sym"} eq $unit;
				$message{$unit} .= "\&$sym ";	# Read-only symbol set
				next symbol;
			}
			$message{$unit} .= "$sym " unless $defined;
		}
	}
	# Warn about any obsolete variable which may be used
	foreach $unit (sort keys %shused) {
		foreach $sym (split(' ', $shused{$unit})) {
			$message{$unit} .= "!$sym " if $Obsolete{$sym} ne '';
		}
	}

	# Warn about stale dependencies, and prepare successor and predecessor
	# tables for later topological sort.

	local($targets, $deps);
	local(%Succ);				# Successors
	local(%Prec);				# Predecessors

	# Split dependencies and build successors array.
	foreach $make (@make) {
		($targets, $deps) = $make =~ m|(.*):\s*(.*)|;
		$deps =~ s/\+(\w)/$1/g;		# Remove conditional targets
		foreach $target (split(' ', $targets)) {
			$Succ{$target} .= $deps . ' ';
		}
	}

	# Special setup for the End target, which normally has a $W dependency for
	# wanted symbols. In order to detect all the possible cycles, we forge a
	# huge dependency by making ALL the regular symbols (i.e. those whose first
	# letter is not uppercased) wanted.

	local($allwant) = '';
	{
		local($sym, $val);
		while (($sym, $val) = each %shmaster) {
			$sym =~ s/^\$//;
			$allwant .= "$sym " if $val ne '';
		}
	}

	$Succ{'End'} =~ s/\$W/$allwant/;

	# Initialize precursors, and spot symbols impossible to 'make', i.e. those
	# symbols listed in the successors and with no 'make' target. The data
	# structures %Prec and %Succ will also be used by the cycle lookup code,
	# in other words, the topological sort.
	foreach $target (keys %Succ) {
		$Prec{$target} += 0;	# Ensure key is recorded without disturbing.
		foreach $succ (split(' ', $Succ{$target})) {
			$Prec{$succ}++;		# Successor has one more precursor
			unless (defined $Succ{$succ} || $said{$succ}++) {
				foreach $unit (split(' ', $symdep{$succ})) {
					$message{$unit} .= "?$succ ";	# Stale ?MAKE: dependency
				}
			}
		}
	}
	undef %symdep;

	# Check all ?M: dependencies to spot stale ones
	%said = ();
	while (($key, $value) = each(%msym)) {
		next if $value eq '';	# Value is unit name where ?M: occurred
		foreach $sym (split(' ', $mdep{$key})) {	# Loop on C dependencies
			next if $cmaster{$sym} || $said{$sym};
			$message{$value} .= "??$sym ";	# Stale ?M: dependency
			$said{$sym}++;
		}
	}

	undef %said;
	undef %mdep;
	undef %msym;

	# Now actually emit all the warnings
	local($uv);			# Unit defining visible symbol or private file
	local($w);			# Were we are signaling an error
	foreach $unit (sort keys %message) {
		undef %said;
		$w = "\"$unit.U\"";
		foreach (split(' ', $message{$unit})) {
			if (s/^#//) {
				warn "$w: symbol '\$$_' has no default value.\n";
			} elsif (s/^\?\?//) {
				warn "$w: stale ?M: dependency '$_'.\n";
			} elsif (s/^\?//) {
				warn "$w: stale ?MAKE: dependency '$_'.\n";
			} elsif (s/^\$//) {
				if ($shmaster{"\$$_"} ne '') {
					warn "$w: symbol '\$$_' missing from ?MAKE.\n";
				} elsif (($uv = $shvisible{$_}) ne '') {
					warn "$w: missing $uv from ?MAKE for visible '\$$_'.\n";
				} elsif (($uv = $shvisible{"\$$_"}) ne '') {
					warn "$w: missing $uv from ?MAKE for visible '\$$_'.\n";
				} else {
					warn "\"$unit.U\": unknown symbol '\$$_'.\n";
				}
				++$said{$_};
			} elsif (s/^\&//) {
				warn "\"$unit.U\": read-only symbol '\$$_' is set.\n";
				++$said{$_};
			} elsif (s/^!//) {
				warn "\"$unit.U\": obsolete symbol '$_' is used.\n";
				++$said{$_};
			} elsif (s/^\@\@\@//) {
				$uv = '?';		# To spot format errors
				s/^(\w+):// && ($uv = $1);
				warn "$w: local file '$_' may override the one set by $uv.U.\n";
			} elsif (s/^\@\@//) {
				$uv = $filemaster{$_};
				warn "$w: you might not always get file '$_' from $uv.U.\n";
			} elsif (s/^\@//) {
				if ($uv = $filemaster{$_}) {
					warn "$w: missing $uv from ?MAKE for private file '$_'.\n";
				} else {
					warn "$w: unknown private file '$_'.\n";
				}
				++$said{"\@$_"};
			} else {
				warn "\"$unit.U\": undeclared symbol '\$$_' is set.\n"
					unless $said{$_};
			}
		}
	}

	# Memory cleanup
	undef %message;
	undef %said;
	undef %shused;
	undef %shset;
	undef %shspecial;
	undef %shvisible;
	undef %filemaster;

	# Spot multiply defined C symbols
	foreach $sym (keys %cmaster) {
		@sym = split(' ', $cmaster{$sym});
		if (@sym > 1) {
			warn "C symbol '$sym' is defined in the following units:\n";
			foreach (@sym) {
				print STDERR "\t$_.U\n";
			}
		}
	}
	undef %cmaster;		# Memory cleanup

	# Warn about multiply defined symbols. There are three kind of symbols:
	# target symbols, obsolete symbols and temporary symbols.
	# For each of these sets, we make sure the intersection with the other sets
	# is empty. Besides, we make sure target symbols are only defined once.

	local(@sym);
	foreach $sym (keys %shmaster) {
		@sym = split(' ', $shmaster{$sym});
		if (@sym > 1) {
			warn "Shell symbol '$sym' is defined in the following units:\n";
			foreach (@sym) {
				print STDERR "\t$_.U\n";
			}
		}
		$message{$sym} .= 'so ' if $Obsolete{$sym};
		$message{$sym} .= 'st ' if $tempmaster{$sym};
	}
	foreach $sym (keys %tempmaster) {
		$message{$sym} .= 'ot ' if $Obsolete{$sym};
	}
	local($_);
	while (($sym, $_) = each %message) {
		if (/so/) {
			if (/ot/) {
				warn "Shell symbol '$sym' is altogether:\n";
				@sym = split(' ', $shmaster{$sym});
				@sym = grep(s/$/.U/, @sym);
				print STDERR "...defined in: ", join(', ', @sym), "\n";
				print STDERR "...obsoleted by $Obsolete{$sym}.\n";
				@sym = split(' ', $tempmaster{$sym});
				@sym = grep(s/$/.U/, @sym);
				print STDERR "...used as temporary in:", join(', ', @sym), "\n";
			} else {
				warn "Shell symbol '$sym' is both defined and obsoleted:\n";
				@sym = split(' ', $shmaster{$sym});
				@sym = grep(s/$/.U/, @sym);
				print STDERR "...defined in: ", join(', ', @sym), "\n";
				print STDERR "...obsoleted by $Obsolete{$sym}.\n";
			}
		} elsif (/st/) {		# Cannot be ot as it would imply so
			warn "Shell symbol '$sym' is both defined and used as temporary:\n";
			@sym = split(' ', $shmaster{$sym});
			@sym = grep(s/$/.U/, @sym);
			print STDERR "...defined in: ", join(', ', @sym), "\n";
			@sym = split(' ', $tempmaster{$sym});
			@sym = grep(s/$/.U/, @sym);
			print STDERR "...used as temporary in:", join(', ', @sym), "\n";
		} elsif (/ot/) {
			warn "Shell symbol '$sym' obsoleted also used as temporary:\n";
			print STDERR "...obsoleted by $Obsolete{$sym}.\n";
			@sym = split(' ', $tempmaster{$sym});
			@sym = grep(s/$/.U/, @sym);
			print STDERR "...used as temporary in:", join(', ', @sym), "\n";
		}
	}

	# Spot multiply defined files, either private or public ones
	foreach $file (keys %prodfile) {
		@sym = split(' ', $prodfile{$file});
		if (@sym > 1) {
			warn "File '$file' is defined in the following units:\n";
			foreach (@sym) {
				print STDERR "\t$_\n";
			}
		}
	}
	undef %prodfile;


	# Memory cleanup (we still need %shmaster for tsort)
	undef %message;
	undef %tempmaster;
	undef %Obsolete;

	# Make sure there is no dependency cycle
	print "Looking for dependency cycles...\n";
	&tsort(*Succ, *Prec);	# Destroys info from %Prec
}

# Make sure last declaration ended correctly with a ?S:. or ?C:. line.
# The variable '$where' was correctly positionned by the calling routine.
sub check_last_declaration {
	warn "$where: definition of '\$$s_symbol' not closed by '?S:.'.\n"
		if $s_symbol ne '';
	warn "$where: definition of '$c_symbol' not closed by '?C:.'.\n"
		if $c_symbol ne '';
	warn "$where: magic definition of '$m_symbol' not closed by '?M:.'.\n"
		if $m_symbol ne '';
	$s_symbol = $c_symbol = $m_symbol = '';
}

# Make sure the variable is mentionned on the ?MAKE line, if possible in the
# definition section.
# The variable '$where' was correctly positionned by the calling routine.
sub check_definition {
	local($var) = @_;
	warn "$where: variable '\$$var' not even listed on ?MAKE: line.\n"
		unless $defseen{$var} || $condseen{$var} || $depseen{$var};
	warn "$where: variable '\$$var' is defined externally.\n"
		if !$lintextern{$var} && !$defseen{$var} && &wanted($var);
}

# Is symbol declared somewhere?
sub declared {
	&defined($_[0]) || &wanted($_[0]);
}

# Is symbol defined by unit?
sub defined {
	$tempseen{$_[0]} || $defseen{$_[0]} || $lintseen{$_[0]};
}

# Is symbol wanted by unit?
sub wanted {
	$depseen{$_[0]} || $condseen{$_[0]};
}

# Is symbol visible from the unit?
# Locate visible symbols throughout the special units. Each unit having
# some special dependencies (special units wanted) have an entry in the
# %shspecial array, listing all those special dependencies. And each
# symbol made visible by ONE special unit has an entry in the %shvisible
# array.
sub visible {
	local($symbol, $unit) = @_;
	local(%explored);				# Special units we've already explored
	&explore($symbol, $unit);		# Perform recursive search
}

# Recursively explore the dependencies to locate a visible symbol
sub explore {
	local($symbol, $unit) = @_;
	# If unit was already explored, we know it has not been found by following
	# that path.
	return 0 if defined $explored{$unit};
	$explored{$unit} = 0;			# Assume nothing found in this unit
	local($specials) = $shspecial{$unit};
	# Don't waste any time if unit does not have any special units listed
	# in its dependencies.
	return 0 unless $specials;
	foreach $special (split(' ', $specials)) {
		return 1 if (
			$shvisible{"\$$symbol"} eq $unit ||
			$shvisible{$symbol} eq $unit ||
			&explore($symbol, $special)
		);
	}
	0;
}


;# $Id: wanted.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1995/01/11  15:42:37  ram
;# patch45: added % in front of hash table names for perl5's each() (ADO)
;# patch45: tell users about possible extra file-extension lookups
;#
;# Revision 3.0.1.1  1993/10/16  13:56:05  ram
;# patch12: modified to handle ?M: lines
;# patch12: added warning when magic symbols used without proper config
;#
;# Revision 3.0  1993/08/18  12:10:29  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# These two arrays record the file names of the files which may (or may not)
;# contain shell or C symbols known by metaconfig.
;#  @SHlist records the .SH files
;#  @clist records the C-like files (i.e. .[chyl])
;#
;# These files are scanned in turn to see how many symbols known by metaconfig
;# they have. Those symbols are gathered in a Wanted file. As C symbols are
;# not true targets for the forthcoming Makefile, a ">" sign is prepended.
;# Finally, the obsolete symbols are preceded by a "!".
;#
;# When obsolete symbols are found, they are dumped in file 'Obsolete'. Two
;# files are created anyway in the .MT directory. Obsol_h.U and Obsol_sh.U which
;# respectively list the obsoleted symbols (C and shell ones).
;#  Obsol_h.U records obsolete C symbols
;#  Obsol_sh.U records obsolete shell symbols
;#
;# The manifake() routine has to be provided externally.
;#
# Build a wanted file from the files held in @SHlist and @clist arrays
sub build_wanted {
	# If wanted file is already there, parse it to map obsolete if -o option
	# was used. Otherwise, build a new one.
	if (-f 'Wanted') {
		&map_obsolete if $opt_o;			# Build Obsol*.U files
		&dump_obsolete;						# Dump obsolete symbols if any
		return;
	}
	&parse_files;
}

sub parse_files {
	print "Building a Wanted file...\n" unless $opt_s;
	open(WANTED,"| sort | uniq >Wanted") || die "Can't create Wanted.\n";
	unless (-f $NEWMANI) {
		&manifake;
		die "No $NEWMANI--can't build a Wanted file.\n" unless -f $NEWMANI;
	}

	local($search);							# Where to-be-evaled script is held
	local($_) = ' ' x 50000 if $opt_m;		# Pre-extend pattern search space
	local(%visited);						# Records visited files
	local(%lastfound);						# Where last occurence of key was

	# Now we are a little clever, and build a loop to eval so that we don't
	# have to recompile our patterns on every file.  We also use "study" since
	# we are searching the same string for many different things.  Hauls!

	if (@clist) {
		local($others) = $cext ? " $cext" : '';
		print "    Scanning .[chyl]$others files for symbols...\n"
			unless $opt_s;
		$search = ' ' x (40 * (@cmaster + @ocmaster));	# Pre-extend
		$search = "while (<>) {study;\n";				# Init loop over ARGV
		foreach $key (keys(%cmaster)) {
			$search .= "&cmaster('$key') if /\\b$key\\b/;\n";
		}
		foreach $key (grep(!/^\$/, keys %Obsolete)) {
			$search .= "&ofound('$key') if /\\b$key\\b/;\n";
		}
		$search .= "}\n";			# terminate loop
		print $search if $opt_d;
		@ARGV = @clist;
		# Swallow each file as a whole, if memory is available
		undef $/ if $opt_m;
		eval $search;
		eval '';
		$/ = "\n";
		while (($key,$value) = each(%cmaster)) {
			print WANTED $cwanted{$key}, "\n", ">$key", "\n" if $value;
		}
	}

	# If they don't use magic but use magically guarded symbols without
	# their corresponding C symbol dependency, warn them, since they might
	# not know about that portability issue.

	if (@clist && !$opt_M) {
		local($nused);					# list of non-used symbols
		local($warning) = 0;			# true when one warning issued
		foreach $cmag (keys %mwanted) {	# loop over all used magic symbols
			next unless $cmaster{$cmag};
			$nused = '';
			foreach $cdep (split(' ', $mwanted{$cmag})) {
				$nused .= " $cdep" unless $cmaster{$cdep};
			}
			$nused =~ s/^ //;
			$nused = "one of " . $nused if $nused =~ s/ /, /g;
			if ($nused ne '') {
				print "    Warning: $cmag is used without $nused.\n";
				$warning++;
			}
		}
		if ($warning) {
			local($those) = $warning == 1 ? 'that' : 'those';
			local($s) = $warning == 1 ? '' : 's';
			print "Note: $those previous warning$s may be suppressed by -M.\n";
		}
	}

	# Cannot remove $cmaster as it is used later on when building Configure
	undef @clist;
	undef %cwanted;
	undef %mwanted;
	%visited = ();
	%lastfound = ();

	if (@SHlist) {
		local($others) = $shext ? " $shext" : '';
		print "    Scanning .SH$others files for symbols...\n" unless $opt_s;
		$search = ' ' x (40 * (@shmaster + @oshmaster));	# Pre-extend
		$search = "while (<>) {study;\n";
		# All the keys already have a leading '$'
		foreach $key (keys(%shmaster)) {
			$search .= "&shmaster('$key') if /\\$key\\b/;\n";
		}
		foreach $key (grep (/^\$/, keys %Obsolete)) {
			$search .= "&ofound('$key') if /\\$key\\b/;\n";
		}
		$search .= "}\n";
		print $search if $opt_d;
		@ARGV = @SHlist;
		# Swallow each file as a whole, if memory is available
		undef $/ if $opt_m;
		eval $search;
		eval '';
		$/ = "\n";
		while (($key,$value) = each(%shmaster)) {
			if ($value) {
				$key =~ s/^\$//;
				print WANTED $key, "\n";
			}
		}
	}

	# Obsolete symbols, if any, are written in the Wanted file preceded by a
	# '!' character. In case -w is used, we'll thus be able to correctly build
	# the Obsol_h.U and Obsol_sh.U files.

	&add_obsolete;						# Add obsolete symbols in Wanted file

	close WANTED;

	# If obsolete symbols where found, write an Obsolete file which lists where
	# each of them appear and the new symbol to be used. Also write Obsol_h.U
	# and Obsol_sh.U in .MT for later perusal.

	&dump_obsolete;						# Dump obsolete symbols if any

	die "No desirable symbols found--aborting.\n" unless -s 'Wanted';

	# Clean-up memory by freeing useless data structures
	undef @SHlist;
	undef %shmaster;
}

# This routine records matches of C master keys
sub cmaster {
	local($key) = @_;
	$cmaster{$key}++;					# This symbol is wanted
	return unless $opt_t || $opt_M;		# Return if neither -t nor -M
	if ($opt_t &&
		$lastfound{$key} ne $ARGV		# Never mentionned for this file ?
	) {
		$visited{$ARGV}++ || print $ARGV,":\n";
		print "\t$key\n";
		$lastfound{$key} = $ARGV;
	}
	if ($opt_M &&
		defined($mwanted{$key})			# Found a ?M: symbol
	) {
		foreach $csym (split(' ', $mwanted{$key})) {
			$cmaster{$csym}++;			# Activate C symbol dependencies
		}
	}
}

# This routine records matches of obsolete keys (C or shell)
sub ofound {
	local($key) = @_;
	local($_) = $Obsolete{$key};		# Value of new symbol
	$ofound{"$ARGV $key $_"}++;			# Record obsolete match
	$cmaster{$_}++ unless /^\$/;		# A C hit
	$shmaster{$_}++ if /^\$/;			# Or a shell one
	return unless $opt_t;				# Continue if trace option on
	if ($lastfound{$key} ne $ARGV) {	# Never mentionned for this file ?
		$visited{$ARGV}++ || print $ARGV,":\n";
		print "\t$key (obsolete, use $_)\n";
		$lastfound{$key} = $ARGV;
	}
}

# This routine records matches of shell master keys
sub shmaster {
	local($key) = @_;
	$shmaster{$key}++;					# This symbol is wanted
	return unless $opt_t;				# Continue if trace option on
	if ($lastfound{$key} ne $ARGV) {	# Never mentionned for this file ?
		$visited{$ARGV}++ || print $ARGV,":\n";
		print "\t$key\n";
		$lastfound{$key} = $ARGV;
	}
}

# Write obsolete symbols into the Wanted file for later perusal by -w.
sub add_obsolete {
	local($file);						# File where obsolete symbol was found
	local($old);						# Name of this old symbol
	local($new);						# Value of the new symbol to be used
	foreach $key (sort keys %ofound) {
		($file, $old, $new) = ($key =~ /^(\S+)\s+(\S+)\s+(\S+)/);
		if ($new =~ s/^\$//) {			# We found an obsolete shell symbol
			print WANTED "!$old\n";
		} else {						# We found an obsolete C symbol
			print WANTED "!>$old\n";
		}
	}
}

# Map obsolete symbols from Wanted file into %Obsolete and call dump_obsolete
# to actually build the Obsol_sh.U and Obsol_h.U files. Those will be needed
# during the Configure building phase to actually do the remaping.
# The obsolete symbols found are entered in the %ofound array, tagged as from
# file 'XXX', which is specially recognized by dump_obsolete.
sub map_obsolete {
	open(WANTED, 'Wanted') || die "Can't open Wanted file.\n";
	local($new);				# New symbol to be used instead of obsolete one
	while (<WANTED>) {
		chop;
		next unless s/^!//;		# Skip non-obsolete symbols
		if (s/^>//) {					# C symbol
			$new = $Obsolete{$_};		# Fetch new symbol
			$ofound{"XXX $_ $new"}++;	# Record obsolete match (XXX = no file)
		} else {						# Shell symbol
			$new = $Obsolete{"\$$_"};	# Fetch new symbol
			$ofound{"XXX \$$_ $new"}++;	# Record obsolete match (XXX = no file)
		}
	}
	close WANTED;
}


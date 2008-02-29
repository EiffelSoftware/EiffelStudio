;# $Id: xwant.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0  1993/08/18  12:10:32  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# These two arrays record the file names of the files which may (or may not)
;# contain shell or C symbols known by metaconfig.
;#  @SHlist records the .SH files
;#  @clist records the C-like files (i.e. .[chyl])
;#
# Parse files and build cross references
sub build_xref {
	print "Building cross-reference files...\n" unless $opt_s;
	unless (-f $NEWMANI) {
		&manifake;
		die "No $NEWMANI--don't know who to scan.\n" unless -f $NEWMANI;
	}

	open(FUI, "|sort | uniq >I.fui") || die "Can't create I.fui.\n";
	open(UIF, "|sort | uniq >I.uif") || die "Can't create I.uif.\n";

	local($search);							# Where to-be-evaled script is held
	local($_) = ' ' x 50000 if $opt_m;		# Pre-extend pattern search space
	local(%visited);						# Records visited files
	local(%lastfound);						# Where last occurence of key was

	# Map shell symbol names to units by reverse engineering the @Master array
	# which records all the known shell symbols and the units where they
	# are defined.
	foreach $init (@Master) {
		$init =~ /^\?(.*):(.*)=''/ && ($shwanted{"\$$2"} = $1);
	}

	# Now we are a little clever, and build a loop to eval so that we don't
	# have to recompile our patterns on every file.  We also use "study" since
	# we are searching the same string for many different things.  Hauls!

	if (@clist) {
		print "    Scanning .[chyl] files for symbols...\n" unless $opt_s;
		$search = ' ' x (40 * (@cmaster + @ocmaster));	# Pre-extend
		$search = "while (<>) {study;\n";				# Init loop over ARGV
		foreach $key (keys(cmaster)) {
			$search .= "\$cmaster{'$key'} .= \"\$ARGV#\" if /\\b$key\\b/;\n";
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
		while (($key,$value) = each(cmaster)) {
			next if $value eq '';
			foreach $file (sort(split(/#/, $value))) {
				next if $file eq '';
				# %cwanted may contain value separated by \n -- take last one
				@sym = split(/\n/, $cwanted{$key});
				$sym = pop(@sym);
				$shell = "\$$sym";
				print FUI
					pack("A35", $file),
					pack("A20", "$shwanted{$shell}.U"),
					$key, "\n";
				print UIF
					pack("A20", "$shwanted{$shell}.U"),
					pack("A25", $key),
					$file, "\n";
			}
		}
	}

	undef @clist;
	undef %cwanted;
	undef %cmaster;		# We're not building Configure, we may delete this
	%visited = ();
	%lastfound = ();

	if (@SHlist) {
		print "    Scanning .SH files for symbols...\n" unless $opt_s;
		$search = ' ' x (40 * (@shmaster + @oshmaster));	# Pre-extend
		$search = "while (<>) {study;\n";
		# All the keys already have a leading '$'
		foreach $key (keys(shmaster)) {
			$search .= "\$shmaster{'$key'} .= \"\$ARGV#\" if /\\$key\\b/;\n";
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
		while (($key,$value) = each(shmaster)) {
			next if $value eq '';
			foreach $file (sort(split(/#/, $value))) {
				next if $file eq '';
				print FUI
					pack("A35", $file),
					pack("A20", "$shwanted{$key}.U"),
					$key, "\n";
				print UIF
					pack("A20", "$shwanted{$key}.U"),
					pack("A25", $key),
					$file, "\n";
			}
		}
	}

	close FUI;
	close UIF;

	# If obsolete symbols where found, write an Obsolete file which lists where
	# each of them appear and the new symbol to be used. Also write Obsol_h.U
	# and Obsol_sh.U in .MT for later perusal.

	&dump_obsolete;						# Dump obsolete symbols if any

	# Clean-up memory by freeing useless data structures
	undef @SHlist;
	undef %shmaster;
}

# This routine records matches of obsolete keys (C or shell)
sub ofound {
	local($key) = @_;
	local($_) = $Obsolete{$key};		# Value of new symbol
	$ofound{"$ARGV $key $_"}++;			# Record obsolete match
	$cmaster{$_} .= "$ARGV#" unless /^\$/;	# A C hit
	$shmaster{$_} .= "$ARGV#" if /^\$/;		# Or a shell one
}


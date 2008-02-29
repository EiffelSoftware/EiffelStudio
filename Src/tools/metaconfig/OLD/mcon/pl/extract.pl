;# $Id: extract.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1994/05/06  15:21:43  ram
;# patch23: now saves the last unit line value for metalint
;#
;# Revision 3.0  1993/08/18  12:10:22  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# This is the heart of the dependency extractor. Each control line is
;# processed. The dependencies are stored in $dependencies.
;#
# Extract dependencies from units held in @ARGV
sub extract_dependencies {
	local($proc);						# Procedure used to handle a ctrl line
	local($file);						# Current file scanned
	local($dir, $unit);					# Directory and unit's name
	local($old_version) = 0;			# True when old-version unit detected
	local($mc) = "$MC/U";				# Public metaconfig directory
	local($line);						# Last processed line for metalint

	printf "Extracting dependency lists from %d units...\n", $#ARGV+1
		unless $opt_s;

	chdir $WD;							# Back to working directory
	&init_extraction;					# Initialize extraction files
	$dependencies = ' ' x (50 * @ARGV);	# Pre-extend
	$dependencies = '';

	# We do not want to use the <> construct here, because we need the
	# name of the opened files (to get the unit's name) and we want to
	# reset the line number for each files, and do some pre-processing.

	file: while ($file = shift(@ARGV)) {
		close FILE;						# Reset line number
		$old_version = 0;				# True if unit is an old version
		if (open(FILE, $file)) {
			($dir, $unit) = ('', $file)
				unless ($dir, $unit) = ($file =~ m|(.*)/(.*)|);
			$unit =~ s|\.U$||;			# Remove extension
		} else {
			warn("Can't open $file.\n");
		}
		# If unit is in the standard public directory, keep only the unit name
		$file = "$unit.U" if $dir eq $mc;
		print "$dir/$unit.U:\n" if $opt_d;
		line: while (<FILE>) {
			$line = $_;					# Save last processed unit line
			if (s/^\?([\w\-]+)://) { 	# We may have found a control line
				$proc = $Depend{$1};	# Look for a procedure to handle it
				unless ($proc) {		# Unknown control line
					$proc = $1;			# p_unknown expects symbol in '$proc'
					eval '&p_unknown';	# Signal error (metalint only)
					next line;			# And go on next line
				}
				# Long lines may be escaped with a final backslash
				$_ .= &complete_line(FILE) if s/\\\s*$//;
				# Run macros substitutions
				s/%</$unit/g;			# %< expands into the unit's name
				if (s/%\*/$unit/) {
					# %* expanded into the entire set of defined symbols
					# in the old version. Now it is only the unit's name.
					++$old_version;
				}
				eval { &$proc($_) };		# Process the line
			} else {
				next file unless $body;		# No procedure to handle body
				do {
					$line = $_;				# Save last processed unit line
					eval { &$body($_) } ;	# From now on, it's the unit body
				} while (defined ($_ = <FILE>));
				next file;
			}
		}
	} continue {
		warn("    Warning: $file is a pre-3.0 version.\n") if $old_version;
		&$ending($line) if $ending;			# Post-processing for metalint
	}

	&end_extraction;		# End the extraction process
}

# The first line was escaped with a final \ character. Every following line
# is to be appended to it (until we found a real \n not escaped). Note that
# the leading spaces of the continuation line are removed, so any space should
# be added before the former \ if needed.
sub complete_line {
	local($file) = @_;		# File where lines come from
	local($_);
	local($read) = '';		# Concatenation of all the continuation lines found
	while (<$file>) {
		s/^\s+//;				# Remove leading spaces
		if (s/\\\s*$//) {		# Still followed by a continuation line
			$read .= $_;	
		} else {				# We've reached the end of the continuation
			return $read . $_;
		}
	}
}


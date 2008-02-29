;# $Id: locate.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1994/10/29  16:36:52  ram
;# patch36: misspelled a 'closedir' as a 'close' statement
;#
;# Revision 3.0  1993/08/18  12:10:25  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# Locate units and put them in the @ARGV array, for later perusal. We first
;# look in the private U directory, then in the public U library. In each U
;# directory, units may be gathered in clusters (directories). These clusters
;# should not have a name ending with .U, as those will never be stat()'ed.
;#
;# NB: Currently, the clusters are only a practical way of grouping a set of
;# closely related units. There must not be any name conflicts.
;#
;# The following variables are used:
;#  $WD is assumed to be the working directory (where the process was spawned)
;#  $MC is the location of metaconfig's public library
;#  @ARGV is the list of all the units full path
;#  %Unit maps an unit name (without final .U) to a path
;#  @myUlist lists the user's units, which will be appended at the end of @ARGV
;#  %myUseen lists the user's units which overwrite public ones
;#
package locate;

# Locate the units and push their path in @ARGV (sorted alphabetically)
sub main'locate_units {
	print "Locating units...\n" unless $main'opt_s;
	local(*WD) = *main'WD;			# Current working directory
	local(*MC) = *main'MC;			# Public metaconfig library
	undef %myUlist;					# Records private units paths
	undef %myUseen;					# Records private/public conflicts
	&private_units;					# Locate private units in @myUlist
	&public_units;					# Locate public units in @ARGV
	@ARGV = sort @ARGV;				# Sort it alphabetically
	push(@ARGV, sort @myUlist);		# Append user's units sorted
	&dump_list if $main'opt_v;		# Dump the list of units
}

# Dump the list of units on stdout
sub dump_list {
	print "\t";
	$, = "\n\t";
	print @ARGV;
	$, = '';
	print "\n";
}

# Scan private units
sub private_units {
	return unless -d 'U';			# Nothing to be done if no 'U' entry
	local(*ARGV) = *myUlist;		# Really fill in @myUlist
	local($MC) = $WD;				# We are really in the working directory
	&units_path("U");				# Locate units in the U directory
	local($unit_name);				# Unit's name (without .U)
	local(@kept);					# Array of kept units
	# Loop over the units and remove duplicates (the first one seen is the one
	# we keep). Also set the %myUseen H table to record private units seen.
	foreach (@ARGV) {
		($unit_name) = m|^.*/(.*)\.U$|;	# Get unit's name from path
		next if $myUseen{$unit_name};	# Already recorded
		$myUseen{$unit_name} = 1;		# Record pirvate unit
		push(@kept, $_);				# Keep this unit
	}
	@ARGV = @kept;
}

# Scan public units
sub public_units {
	chdir($MC) || die "Can't find directory $MC.\n";
	&units_path("U");				# Locate units in public U directory
	chdir($WD) || die "Can't go back to directory $WD.\n";
	local($path);					# Relative path from $WD
	local($unit_name);				# Unit's name (without .U)
	local(*Unit) = *main'Unit;		# Unit is a global from main package
	local(@kept);					# Units kept
	local(%warned);					# Units which have already issued a message
	# Loop over all the units and keep only the ones that were not found in
	# the user's U directory. As it is possible two or more units with the same
	# name be found in
	foreach (@ARGV) {
		($unit_name) = m|^.*/(.*)\.U$|;	# Get unit's name from path
		next if $warned{$unit_name};	# We have already seen this unit
		$warned{$unit_name} = 1;		# Remember we have warned the user
		if ($myUseen{$unit_name}) {		# User already has a private unit
			$path = $Unit{$unit_name};	# Extract user's unit path
			next if $path eq $_;		# Same path, we must be in mcon/
			$path =~ s|^$WD/||o;		# Weed out leading working dir path
			print "    Your private $path overrides the public one.\n"
				unless $main'opt_s;
		} else {
			push(@kept, $_);			# We may keep this one
		}
	}
	@ARGV = @kept;
}

# Recursively locate units in the directory. Each file ending with .U has to be
# a unit. Others are stat()'ed, and if they are a directory, they are also
# scanned through. The $MC and @ARGV variable are dynamically set by the caller.
sub units_path {
	local($dir) = @_;					# Directory where units are to be found
	local(@contents);					# Contents of the directory
	local($unit_name);					# Unit's name, without final .U
	local($path);						# Full path of a unit
	local(*Unit) = *main'Unit;			# Unit is a global from main package
	unless (opendir(DIR, $dir)) {
		warn("Cannot open directory $dir.\n");
		return;
	}
	print "Locating in $MC/$dir...\n" if $main'opt_v;
	@contents = readdir DIR;			# Slurp the whole thing
	closedir DIR;						# And close dir, ready for recursion
	foreach (@contents) {
		next if $_ eq '.' || $_ eq '..';
		if (/\.U$/) {					# A unit, definitely
			($unit_name) = /^(.*)\.U$/;
			$path = "$MC/$dir/$_";				# Full path of unit
			push(@ARGV, $path);					# Record its path
			if (defined $Unit{$unit_name}) {	# Already seen this unit
				if ($main'opt_v) {
					($path) = $Unit{$unit_name} =~ m|^(.*)/.*|;
					print "    We've already seen $unit_name.U in $path.\n";
				}
			} else {
				$Unit{$unit_name} = $path;		# Map name to path
			}
			next;
		}
		# We have found a file which does not look like a unit. If it is a
		# directory, then scan it. Otherwise skip the file.
		unless (-d "$dir/$_") {
			print "    Skipping file $_ in $dir.\n" if $main'opt_v;
			next;
		}
		&units_path("$dir/$_");
		print "Back to $MC/$dir...\n" if $main'opt_v;
	}
}

package main;


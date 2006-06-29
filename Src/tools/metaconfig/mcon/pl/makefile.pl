;# $Id: makefile.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1995/09/25  09:19:42  ram
;# patch59: symbols are now sorted according to the ?Y: layout directive
;#
;# Revision 3.0  1993/08/18  12:10:26  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# Given a list of wanted symbols in the Wanted file, produce a Makefile which
;# will compute the transitive closure of dependencies for us and give the
;# correct layout order in the Configure script. Because some conditional
;# symbols could indeed be truly wanted symbols, we build the makefile in two
;# passes. The first one will give us the complete list of units to be loaded,
;# while the second will determine the correct order.
;#
;# The external $saved_dependencies records the original dependencies we got
;# from the units' ?MAKE: lines while $dependencies is tampered with.
;#
;# Note that when the -w option is supplied, the sources are not parsed.
;# However, the config.h.SH file would be empty, because its building
;# relies on values in cmaster and shmaster arrays. It is okay for values
;# in shmaster, because they are true wanted symbols. The cmaster keys
;# have also been written, but with a leading '>' (because they are
;# not true targets for Makefile). We thus extract all these keys and
;# set the cmaster array accordingly.
;#
;# Obsolete symbols, if any found, are also part of the Wanted file, written on
;# a line starting with a '!', eventually followed by a '>' if the obsolete
;# symbol is a C one.
;#
;# These three data structures record wanted things like commands or symbols.
;#  %symwanted{'sym'} is true when the symbol is wanted (transitive closure)
;#  %condwanted{'sym'} when the default value of a symbol is requested
;#  $wanted records the set of wanted shell symbols (as opposed to C ones)
;#
# Build the private makefile we use to compute the transitive closure of the
# previously determined dependencies.
sub build_makefile {
	print "Computing optimal dependency graph...\n" unless $opt_s;
	chdir('.MT') || die "Can't chdir to .MT\n";
	local($wanted);			# Wanted shell symbols
	&build_private;			# Build a first makefile from dependencies
	&compute_loadable;		# Compute loadable units
	&update_makefile;		# Update makefile using feedback from first pass
	chdir($WD) || die "Can't chdir back to $WD\n";
	# Free memory by removing useless data structures
	undef $dependencies;
	undef $saved_dependencies;
}

# First pass: build a private makefile from the extracted dependency, changing
# conditional units to truly wanted ones if the symbol is used, removing the
# dependency otherwise. The original dependencies are saved.
sub build_private {
	print "    Building private make file...\n" unless $opt_s;
	open(WANTED,"../Wanted") || die "Can't reopen Wanted.\n";
	$wanted = ' ' x 2000;	# Pre-extend string
	$wanted = '';
	while (<WANTED>) {
		chop;
		next if /^!/;		# Skip obsolete symbols
		if (s/^>//) {
			$cmaster{$_}++;
		} else {
			$wanted .= "$_ ";
		}
	}
	close WANTED;

	# The wanted symbols are sorted so that d_* (checking for C library symbol)
	# come first and i_* (checking for includes) comes at the end. Grouping the
	# d_* symbols together has good chances of improving the locality of the
	# other questions and i_* symbols must come last since some depend on h_*
	# values which prevent incompatible headers inclusions.
	$wanted = join(' ', sort symbols split(' ', $wanted));
	
	# Now generate the first makefile, which will be used to determine which
	# symbols we really need, so that conditional dependencies may be solved.
	open(MAKEFILE,">Makefile") || die "Can't create .MT/Makefile.\n";
	print MAKEFILE "SHELL = /bin/sh\n";
	print MAKEFILE "W = $wanted\n";
	$saved_dependencies = $dependencies;
	$* = 1;
	foreach $sym (@Cond) {
		if ($symwanted{$sym}) {
			$dependencies =~ s/\+($sym\s)/$1/g;
		} else {
			$dependencies =~ s/\+$sym(\s)/$1/g;
		}
	}
	$* = 0;
	print MAKEFILE $dependencies;
	close MAKEFILE;
}

# Ordering for symbols. Give higher priority to d_* ones and lower to i_* ones.
# If any layout priority is defined in %Layout, it is used to order the
# symbols.
sub symbols {
	local($r) = $Layout{$a} <=> $Layout{$b};
	return $r if $r;
	# If we come here, both symbols have the same layout priority.
	if ($a =~ /^d_/) {
		return -1 unless $b =~ /^d_/;
	} elsif ($b =~ /^d_/) {
		return 1;
	} elsif ($a =~ /^i_/) {
		return 1 unless $b =~ /^i_/;
	} elsif ($b =~ /^i_/) {
		return -1;
	}
	$a cmp $b;
}

# Run the makefile produced in the first pass to find the whole set of units we
# have to load, filling in the %symwanted and %condwanted structures.
sub compute_loadable {
	print "    Determining loadable units...\n" unless $opt_s;
	open(MAKE, "make -n |") || die "Can't run make";
	while (<MAKE>) {
		s|^\s+||;				# Some make print tabs before command
		if (/^pick/) {
			print "\t$_" if $opt_v;
			($pick,$cmd,$symbol,$unit) = split(' ');
			$symwanted{$symbol}++;
			$symwanted{$unit}++;
		} elsif (/^cond/) {
			print "\t$_" if $opt_v;
			($pick,@symbol) = split(' ');
			for (@symbol) {
				$condwanted{$_}++;	# Default value is requested
			}
		}
	}
	close MAKE;
}

# Now that we know all the desirable symbols, we have to rebuild
# another makefile, in order to have the units in a more optimal
# way.
# Actually, if we have both ?MAKE:a:+b and ?MAKE:d:b and 'd' is
# wanted; then 'b' will be loaded. However, 'b' is a conditional
# dependency for 'a', and it would be better if 'b' were loaded
# before 'a' is, though this is not necessary.
# It is hard to know that 'b' will be loaded *before* the first make.

# Back to the original dependencies, make loadable units truly wanted ones and
# remove optional ones.
sub update_makefile {
	print "    Updating make file...\n" unless $opt_s;
	open(MAKEFILE,">Makefile") || die "Can't create .MT/Makefile.\n";
	print MAKEFILE "SHELL = /bin/sh\n";
	print MAKEFILE "W = $wanted\n";
	$* = 1;
	foreach $sym (@Cond) {
		if ($symwanted{$sym}) {
			$saved_dependencies =~ s/\+($sym\s)/$1/g;
		} else {
			$saved_dependencies =~ s/\+$sym(\s)/$1/g;
		}
	}
	$* = 0;
	print MAKEFILE $saved_dependencies;
	close MAKEFILE;
}


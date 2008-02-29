;# $Id: configure.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.5  1995/01/30  14:47:15  ram
;# patch49: removed old "do name()" routine call constructs
;#
;# Revision 3.0.1.4  1995/01/11  15:40:02  ram
;# patch45: now allows @if statements for the add.Config_sh unit inclusion
;#
;# Revision 3.0.1.3  1994/05/06  15:21:23  ram
;# patch23: cleaned up the 'prepend' command
;#
;# Revision 3.0.1.2  1994/01/24  14:23:21  ram
;# patch16: new general <\$variable> macro substitutions in wiped units
;#
;# Revision 3.0.1.1  1993/10/16  13:54:02  ram
;# patch12: added support for ?M: lines and confmagic.h production
;# patch12: new Makefile command cm_h_weed
;#
;# Revision 3.0  1993/08/18  12:10:20  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# This file is the heart of metaconfig. We generate a Configure script using
;# the informations gathered in the @cmdwanted array. A unit is expected to have
;# its path written in the %Unit array (indexing is done with the unit's name
;# without the .U extension).
;#
;# The units are run through a built-in interpreter before being written to
;# the Configure script.
;#
# Create the Configure script
sub create_configure {
	print "Creating Configure...\n" unless $opt_s;
	open(CONFIGURE,">Configure") || die "Can't create Configure: $!\n";
	open(CONF_H,">config_h.SH") || die "Can't create config_h.SH: $!\n";
	if ($opt_M) {
		open(MAGIC_H,">confmagic.h") || die "Can't create confmagic.h: $!\n";
	}

	chdir('.MT') || die "Can't cd to .MT: $!\n";
	for (@cmdwanted) {
		&process_command($_);		# Run the makefile command
	}
	chdir($WD) || die "Can't cd back to $WD\n";
	close CONFIGURE;
	print CONF_H "#endif\n";		# Close the opened #ifdef (see Config_h.U)
	print CONF_H "!GROK!THIS!\n";
	close CONF_H;
	if ($opt_M) {
		print MAGIC_H "#endif\n";	# Close the opened #ifdef (see Magic_h.U)
		close MAGIC_H;
	}
	`chmod +x Configure`;
}

# Process a Makefile 'pick' command
sub process_command {
	local($cmd, $target, $unit_name) = split(' ', $_[0]);
	local($name) = $unit_name . '.U';	# Restore missing .U
	local($file) = $name;				# Where unit is located
	unless ($file =~ m|^\./|) {			# Unit produced earlier by metaconfig
		$file = $Unit{$unit_name};		# Fetch unit from U directory
	}
	if (defined $Obsolete{$name}) {		# Signal use of an obsolete unit
		warn "\tObsolete unit $name is used:\n";
		local(@msg) = split(/\n/, $Obsolete{$name});
		foreach $msg (@msg) {
			warn "\t    $msg\n";
		}
	}
	die "Can't open $file.\n" unless open(UNIT, $file);
	print "\t$cmd $file\n" if $opt_v;
	&init_interp;						# Initializes the interpreter

	# The 'add' command adds the unit to Configure.
	if ($cmd eq 'add') {
		while (<UNIT>) {
			print CONFIGURE unless &skipped || !&interpret($_);
		}
	}
	
	# The 'weed' command adds the unit to Configure, but
	# makes some tests for the lines starting with '?' or '%'.
	# These lines are kept only if the symbol is wanted.
	elsif ($cmd eq 'weed') {
		while (<UNIT>) {
			if (/^\?(\w+):/) {
				s/^\?\w+:// if $symwanted{$1};
			}
			if (/^%(\w+):/) {
				s/^%\w+:// if $condwanted{$1};
			}
			print CONFIGURE unless &skipped || !&interpret($_);
		}
	}
	
	# The 'wipe' command adds the unit to Configure, but
	# also substitues some hardwired macros.
	elsif ($cmd eq 'wipe') {
		while (<UNIT>) {
			s/<PACKAGENAME>/$package/g;
			s/<MAINTLOC>/$maintloc/g;
			s/<VERSION>/$version/g;			# This is metaconfig's version
			s/<PATCHLEVEL>/$patchlevel/g;	# And patchlevel information
			s/<DATE>/$date/g;
			s/<BASEREV>/$baserev/g;
			s/<\$(\w+)>/eval("\$$1")/ge;	# <$var> -> $var substitution
			print CONFIGURE unless &skipped || !&interpret($_);
		}
	}
	
	# The 'add.Null' command adds empty initializations
	# to Configure for all the shell variable used.
	elsif ($cmd eq 'add.Null') {
		for (sort @Master) {
			if (/^\?(\w+):/) {
				s/^\?\w+:// if $symwanted{$1};
			}
			print CONFIGURE unless &skipped;
		}
		for (sort @Cond) {
			print CONFIGURE "$_=''\n"
				unless $symwanted{$_} || $hasdefault{$_};
		}
		while (<UNIT>) {
			print CONFIGURE unless &skipped || !&interpret($_);
		}
		print CONFIGURE "CONFIG=''\n\n";
	}
	
	# The 'add.Config_sh' command fills in the production of
	# the config.sh script within Configure. Only the used
	# variable are added, the conditional ones are skipped.
	elsif ($cmd eq 'add.Config_sh') {
		while (<UNIT>) {
			print CONFIGURE unless &skipped || !&interpret($_);
		}
		for (sort @Master) {
			if (/^\?(\w+):/) {
				# Can't use $shmaster, because config.sh must
				# also contain some internal defaults used by
				# Configure (e.g. nm_opt, libc, etc...).
				s/^\?\w+:// if $symwanted{$1};
			}
			s/^(\w+)=''/$1='\$$1'/;
			print CONFIGURE unless &skipped;
		}
	}
	
	# The 'close.Config_sh' command adds the final EOT line at
	# the end of the here-document construct which produces the
	# config.sh file within Configure.
	elsif ($cmd eq 'close.Config_sh') {
		print CONFIGURE "EOT\n\n";	# Ends up file
	}

	# The 'c_h_weed' command produces the config_h.SH file.
	# Only the necessary lines are kept. If no conditional line is
	# ever printed, then the file is useless and will be removed.
	elsif ($cmd eq 'c_h_weed') {
		$printed = 0;
		while (<UNIT>) {
			if (/^\?(\w+):/) {
				s/^\?\w+:// if $cmaster{$1} || $symwanted{$1};
			}
			unless (&skipped || !&interpret($_)) {
				if (/^$/) {
					print CONF_H "\n" if $printed;
					$printed = 0;
				} else {
					print CONF_H;
					++$printed;
				}
			}
		}
	}
	
	# The 'cm_h_weed' command produces the confmagic.h file.
	# Only the necessary lines are kept. If no conditional line is
	# ever printed, then the file is useless and will be removed.
	elsif ($cmd eq 'cm_h_weed') {
		if ($opt_M) {
			$printed = 0;
			while (<UNIT>) {
				if (/^\?(\w+):/) {
					s/^\?\w+:// if $cmaster{$1} || $symwanted{$1};
				}
				unless (&skipped || !&interpret($_)) {
					if (/^$/) {
						print MAGIC_H "\n" if $printed;
						$printed = 0;
					} else {
						print MAGIC_H;
						++$printed;
					}
				}
			}
		}
	}
	
	# The 'prepend' command will add the content of the target to
	# the current file (held in $file, the one which UNIT refers to),
	# if the file is not empty.
	elsif ($cmd eq 'prepend') {
		if (-s $file) {
			open(PREPEND, ">.prepend") ||
				die "Can't create .MT/.prepend.\n";
			open(TARGET, $Unit{$target}) ||
				die "Can't open $Unit{$target}.\n";
			while (<TARGET>) {
				print PREPEND unless &skipped;
			}
			print PREPEND <UNIT>;	# Now add original file contents
			close PREPEND;
			close TARGET;
			rename('.prepend', $file) ||
				die "Can't rename .prepend into $file.\n";
		}
	}

	# Command not found
	else {
		die "Unrecognized command from Makefile: $cmd\n";
	}
	&check_state;		# Make sure there are no pending statements
	close UNIT;
}

# Skip lines starting with ? or %, including all the following continuation
# lines, if any. Return 0 if the line was not to be skipped, 1 otherwise.
sub skipped {
	return 0 unless /^\?|^%/;
	&complete_line(UNIT) if /\\\s*$/;	# Swallow continuation lines
	1;
}


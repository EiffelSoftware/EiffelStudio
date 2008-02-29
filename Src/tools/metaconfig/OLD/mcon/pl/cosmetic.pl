;# $Id: cosmetic.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.3  1995/07/25  14:19:16  ram
;# patch56: added support for new -G option
;#
;# Revision 3.0.1.2  1995/01/30  14:47:52  ram
;# patch49: forgot to localize the spaces variable
;#
;# Revision 3.0.1.1  1993/11/10  17:39:10  ram
;# patch14: now also adds confmagic.h if not in MANIFEST.new already
;# patch14: new functions mani_add and mani_remove to factorize code
;#
;# Revision 3.0  1993/08/18  12:10:20  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
# Update the MANIFEST.new file if necessary
sub cosmetic_update {
	# Check for an "empty" config_h.SH (2 blank lines only). This test relies
	# on the actual text held in Config_h.U. If the unit is modified, then the
	# following might need adjustments.
	local($blank_lines) = 0;
	local($spaces) = 0;
	open(CONF_H, 'config_h.SH') || die "Can't open config_h.SH\n";
	while(<CONF_H>) {
		++$blank_lines if /^$/;
	}
	unlink 'config_h.SH' unless $blank_lines > 3;

	open(NEWMANI,$NEWMANI);
	$_ = <NEWMANI>;
	/(\S+\s+)\S+/ && ($spaces = length($1));	# Spaces wanted
	close NEWMANI;
	$spaces = 29 if ($spaces < 12);				# Default value
	open(NEWMANI,$NEWMANI);
	$/ = "\001";			# Swallow the whole file
	$_ = <NEWMANI>;
	$/ = "\n";
	close NEWMANI;

	$* = 1;					# Multi-line matching

	&mani_add('Configure', 'Portability tool', $spaces) unless /^Configure\b/;
	&mani_add('config_h.SH', 'Produces config.h', $spaces)
		unless /^config_h\.SH\b/ || !-f 'config_h.SH';
	&mani_add('confmagic.h', 'Magic symbol remapping', $spaces)
		if $opt_M && !/^confmagic\.h\b/;

	&mani_remove('config_h.SH') if /^config_h\.SH\b/ && !-f 'config_h.SH';
	&mani_remove('confmagic.h') if /^confmagic.h\b/ && !$opt_M;

	if ($opt_G) {			# Want a GNU-like configure wrapper
		&add_configure;
		&mani_add('configure', 'GNU configure-like wrapper', $spaces)
			if !/^configure\b/ && -f 'configure';
	} else {
		&mani_remove('configure') if /^configure\b/ && !-f 'configure';
	}

	$* = 0;
}

# Add file to MANIFEST.new, with properly indented comment
sub mani_add {
	local($file, $comment, $spaces) = @_;
	print "Adding $file to your $NEWMANI file...\n" unless $opt_s;
	open(NEWMANI, ">>$NEWMANI") || warn "Can't add $file to $NEWMANI: $!\n";
	local($blank) = ' ' x ($spaces - length($file));
	print NEWMANI "${file}${blank}${comment}\n";
	close NEWMANI;
}

# Remove file from MANIFEST.new
sub mani_remove {
	local($file) = @_;
	print "Removing $file from $NEWMANI...\n" unless $opt_s;
	unless (open(NEWMANI, ">$NEWMANI.x")) {
		warn "Can't create backup $NEWMANI copy: $!\n";
		return;
	}
	unless (open(OLDMANI, $NEWMANI)) {
		warn "Can't open $NEWMANI: $!\n";
		return;
	}
	local($_);
	while (<OLDMANI>) {
		print NEWMANI unless /^$file\b/
	}
	close OLDMANI;
	close NEWMANI;
	rename("$NEWMANI.x", $NEWMANI) ||
		warn "Couldn't restore $NEWMANI from $NEWMANI.x\n";
}

# Copy GNU-like configure wrapper to the package root directory
sub add_configure {
	if (-f "$MC/configure") {
		print "Copying GNU configure-like front end...\n" unless $opt_s;
		system "cp $MC/configure ./configure";
		`chmod +x configure`;
	} else {
		warn "Can't locate $MC/configure: $!\n";
	}
}


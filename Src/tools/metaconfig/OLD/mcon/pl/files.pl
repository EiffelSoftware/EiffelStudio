;# $Id: files.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1994/10/29  16:35:48  ram
;# patch36: added user-defined file extension support for lookups
;#
;# Revision 3.0.1.1  1993/10/16  13:54:55  ram
;# patch12: now skip confmagic.h when -M option is used
;#
;# Revision 3.0  1993/08/18  12:10:23  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# These two arrays record the file names of the files which may (or may not)
;# contain shell or C symbols known by metaconfig.
;#  @SHlist records the .SH files
;#  @clist records the C-like files (i.e. .[chyl])
;#
;# The extensions are actually computed dynamically from the definitions held
;# in the $cext and $shext variables from .package so that people can add new
;# extensions to their packages. For instance, perl5 adds .xs files holding
;# some C symbols.
;#
# Extract filenames from manifest
sub extract_filenames {
	&build_filext;			# Construct &is_cfile and &is_shfile
	print "Extracting filenames (C and SH files) from $NEWMANI...\n"
		unless $opt_s;
	open(NEWMANI,$NEWMANI) || die "Can't open $NEWMANI.\n";
	local($file);
	while (<NEWMANI>) {
		($file) = split(' ');
		next if $file eq 'config_h.SH';			# skip config_h.SH
		next if $file eq 'Configure';			# also skip Configure
		next if $file eq 'confmagic.h' && $opt_M;
		push(@SHlist, $file) if &is_shfile($file);
		push(@clist, $file) if &is_cfile($file);
	}
}

# Construct two file identifiers based on the file suffix: one for C files,
# and one for SH files (using the $cext and $shext variables) defined in
# the .package file.
# The &is_cfile and &is_shfile routine may then be called to known whether
# a given file is a candidate for holding C or SH symbols.
sub build_filext {
	&build_extfun('is_cfile', $cext, '.c .h .y .l');
	&build_extfun('is_shfile', $shext, '.SH');
}

# Build routine $name to identify extensions listed in $exts, ensuring
# that $minimum is at least matched (both to be backward compatible with
# older .package and because it is really the minimum requirred).
sub build_extfun {
	local($name, $exts, $minimum) = @_;
	local(@single);		# Single letter dot extensions (may be grouped)
	local(@others);		# Other extensions
	local(%seen);		# Avoid duplicate extensions
	foreach $ext (split(' ', "$exts $minimum")) {
		next if $seen{$ext}++;
		if ($ext =~ s/^\.(\w)$/$1/) {
			push(@single, $ext);
		} else {
			# Convert into perl's regexp
			$ext =~ s/\./\\./g;		# Escape .
			$ext =~ s/\?/./g;		# ? turns into .
			$ext =~ s/\*/.*/g;		# * turns into .*
			push(@others, $ext);
		}
	}
	local($fn) = &q(<<EOF);		# Function being built
:sub $name {
:	local(\$_) = \@_;
EOF
	local($single);		# Single regexp: .c .h grouped into .[ch]
	$single = '\.[' . join('', @single) . ']' if @single;
	$fn .= &q(<<EOL) if @single;
:	return 1 if /$single\$/;
EOL
	foreach $ext (@others) {
		$fn .= &q(<<EOL);
:	return 1 if /$ext\$/;
EOL
	}
	$fn .= &q(<<EOF);
:	0;	# None of the extensions may be applied to file name
:}
EOF
	print $fn if $opt_d;
	eval $fn;
	chop($@) && die "Can't compile '$name':\n$fn\n$@.\n";
}

# Remove ':' quotations in front of the lines
sub q {
	local($_) = @_;
	local($*) = 1;
	s/^://g;
	$_;
}


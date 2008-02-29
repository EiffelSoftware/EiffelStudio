;# $Id: rangeargs.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0  1993/08/18  12:10:58  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub rangeargs {
	local($result) = '';
	local($min,$max,$_);
	open(PL,"patchlevel.h") || die "Can't open patchlevel.h\n";
	while (<PL>) {
		$maxspec = $1 if /^#define\s+PATCHLEVEL\s+(\d+)/;
	}
	close PL;
	die "Malformed patchlevel.h file.\n" if $maxspec eq '';
	while ($#_ >= 0) {
		$_ = shift(@_);
		while (/^\s*\d/) {
			s/^\s*(\d+)//;
			$min = $1;
			if (s/^,//) {
				$max = $min;
			} elsif (s/^-(\d*)//) {
				$max = $1;
				if ($max == 0 && $maxspec) {
					$max = $maxspec;
				}
				s/^[^,],?//;
			} else {
				$max = $min;
			}
			for ($i = $min; $i <= $max; ++$i) {
				$result .= $i . ' ';
			}
		}
	}
	$result;
}


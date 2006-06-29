;# $Id: snapshot.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1993/08/24  12:22:34  ram
;# patch3: created
;#
# Read snapshot file and build %Snap, indexed by file name -> RCS revision
sub readsnapshot {
	local($snap) = @_;
	open(SNAP, $snap) || warn "Can't open $snap: $!\n";
	local($_);
	local($file, $rev);
	while (<SNAP>) {
		next if /^#/;
		($file, $rev) = split;
		$Snap{$file} = "$rev";
	}
	close SNAP;
}


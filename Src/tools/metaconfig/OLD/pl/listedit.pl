;# $Id: listedit.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1993/08/27  14:40:57  ram
;# patch7: forgot to unlink temporary file
;#
;# Revision 3.0.1.1  1993/08/25  14:08:12  ram
;# patch6: created
;#
;# Requires geteditor.pl
;#
# Allow user to inplace-edit a list of items held in an array
sub listedit {
	local(*list) = @_;
	local($tmp) = "/tmp/dist.$$";
	local($editor) = &geteditor;
	open(TMP, ">$tmp") || die "Can't create $tmp: $!\n";
	foreach $item (@list) {
		print TMP $item, "\n";
	}
	close TMP;
	system "$editor $tmp";
	open(TMP, "$tmp") || die "Can't reopen $tmp: $!\n";
	chop(@list = <TMP>);
	close TMP;
	unlink $tmp;
}


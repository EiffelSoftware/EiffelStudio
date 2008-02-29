;# $Id: editor.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.1  1993/08/25  14:08:07  ram
;# patch6: created
;#
# Compute suitable editor name
sub geteditor {
	local($editor) = $ENV{'VISUAL'};
	$editor = $ENV{'EDITOR'} unless $editor;
	$editor = $defeditor unless $editor;
	$editor = 'vi' unless $editor;
	$editor;
}


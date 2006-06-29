;# $Id: init.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1995/09/25  09:19:06  ram
;# patch59: new ?Y: directive to change unit layout
;#
;# Revision 3.0.1.1  1993/10/16  13:55:06  ram
;# patch12: now knows about ?M: lines
;#
;# Revision 3.0  1993/08/18  12:10:24  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
# The %Depend array records the functions we use to process the configuration
# lines in the unit, with a special meaning. It is important that all the
# known control symbols be listed below, so that metalint does not complain.
# The %Lcmp array contains valid layouts and their comparaison value.
sub init_depend {
	%Depend = (
		'MAKE', 'p_make',				# The ?MAKE: line records dependencies
		'INIT', 'p_init',				# Initializations printed verbatim
		'LINT', 'p_lint',				# Hints for metalint
		'RCS', 'p_ignore',				# RCS comments are ignored
		'C', 'p_c',						# C symbols
		'D', 'p_default',				# Default value for conditional symbols
		'E', 'p_example',				# Example of usage
		'F', 'p_file',					# Produced files
		'H', 'p_config',				# Process the config.h lines
		'I', 'p_include',				# Added includes
		'L', 'p_library',				# Added libraries
		'M', 'p_magic',					# Process the confmagic.h lines
		'O', 'p_obsolete',				# Unit obsolescence
		'P', 'p_public',				# Location of PD implementation file
		'S', 'p_shell',					# Shell variables
		'T', 'p_temp',					# Shell temporaries used
		'V', 'p_visible',				# Visible symbols like 'rp', 'dflt'
		'W', 'p_wanted',				# Wanted value for interpreter
		'X', 'p_ignore',				# User comment is ignored
		'Y', 'p_layout',				# User-defined layout preference
	);
	%Lcmp = (
		'top',		-1,
		'default',	0,
		'bottom',	1,
	);
}


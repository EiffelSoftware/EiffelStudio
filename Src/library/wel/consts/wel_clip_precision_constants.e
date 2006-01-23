indexing
	description: "Clipping precision (CLIP) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIP_PRECISION_CONSTANTS

feature -- Access

	Clip_default_precis: INTEGER is 0

	Clip_character_precis: INTEGER is 1

	Clip_stroke_precis: INTEGER is 2

	Clip_mask: INTEGER is 15

	Clip_lh_angles: INTEGER is 16
			-- Declared in Windows as CLIP_LH_ANGLES

	Clip_tt_always: INTEGER is 32
			-- Declared in Windows as CLIP_TT_ALWAYS

	Clip_embedded: INTEGER is 128;
			-- Declared in Windows as CLIP_EMBEDDED

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CLIP_PRECISION_CONSTANTS


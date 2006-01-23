indexing
	description: "Out (OUT) precision constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OUT_PRECISION_CONSTANTS

feature -- Access

	Out_default_precis: INTEGER is 0

	Out_string_precis: INTEGER is 1

	Out_character_precis: INTEGER is 2

	Out_stroke_precis: INTEGER is 3

	Out_tt_precis: INTEGER is 4

	Out_device_precis: INTEGER is 5

	Out_raster_precis: INTEGER is 6

	Out_tt_only_precis: INTEGER is 7;

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




end -- class WEL_OUT_PRECISION_CONSTANTS


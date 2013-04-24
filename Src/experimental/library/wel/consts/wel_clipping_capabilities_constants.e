note
	description: "Clipping capabilities (CP) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPPING_CAPABILITIES_CONSTANTS

feature -- Access

	Cp_none: INTEGER = 0
			-- Output is not clipped

	Cp_rectangle: INTEGER = 1
			-- Output is clipped to rectangles

	Cp_region: INTEGER = 2;
			-- Output is clipped to regions

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CLIPPING_CAPABILITIES_CONSTANTS


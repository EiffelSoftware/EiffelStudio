indexing
	description: "Track Mouse Event (TME) constants for use by %
		% WEL_TRACK_MOUSE_EVENT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TME_CONSTANTS

feature -- Access

	Tme_cancel: INTEGER is -2147483648
			-- Declared in Windows as TME_CANCEL

	Tme_hover: INTEGER is 1
			-- Declared in Windows as TME_HOVER

	Tme_leave: INTEGER is 2
			-- Declared in Windows as TME_LEAVE

	Tme_query: INTEGER is 1073741824;
			-- Declared in Windows as TME_QUERY

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




end -- class WEL_TME_CONSTANTS


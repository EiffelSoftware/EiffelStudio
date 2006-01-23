indexing
	description: "Tooltip Notification (TTN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTN_CONSTANTS

feature -- Access

	Ttn_needtext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_NEEDTEXT"
		end

	Ttn_pop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_POP"
		end

	Ttn_show: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_SHOW"
		end

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




end -- class WEL_TTN_CONSTANTS


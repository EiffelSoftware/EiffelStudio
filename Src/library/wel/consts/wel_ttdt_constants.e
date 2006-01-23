indexing
	description: "Tooltip Delay Time (TTDT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTDT_CONSTANTS

feature -- Access

	Ttdt_automatic: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOMATIC"
		end

	Ttdt_autopop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOPOP"
		end

	Ttdt_initial: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_INITIAL"
		end

	Ttdt_reshow: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_RESHOW"
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




end -- class WEL_TTDT_CONSTANTS


indexing
	description: "GetWindow (GW) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GW_CONSTANTS

feature -- Access

	Gw_hwndfirst: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDFIRST"
		end

	Gw_hwndlast: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDLAST"
		end

	Gw_hwndnext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDNEXT"
		end

	Gw_hwndprev: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDPREV"
		end

	Gw_owner: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_OWNER"
		end

	Gw_child: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_CHILD"
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




end -- class WEL_GW_CONSTANTS


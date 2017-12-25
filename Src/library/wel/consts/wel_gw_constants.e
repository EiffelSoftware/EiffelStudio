note
	description: "GetWindow (GW) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GW_CONSTANTS

feature -- Access

	Gw_hwndfirst: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDFIRST"
		ensure
			is_class: class
		end

	Gw_hwndlast: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDLAST"
		ensure
			is_class: class
		end

	Gw_hwndnext: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDNEXT"
		ensure
			is_class: class
		end

	Gw_hwndprev: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDPREV"
		ensure
			is_class: class
		end

	Gw_owner: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_OWNER"
		ensure
			is_class: class
		end

	Gw_child: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_CHILD"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

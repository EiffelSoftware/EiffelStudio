indexing
	description: "Stretch mode constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRETCH_MODE_CONSTANTS

feature -- Access

	frozen Stretch_andscans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_ANDSCANS"
		end

	frozen Stretch_deletescans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_DELETESCANS"
		end

	frozen Stretch_orscans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_ORSCANS"
		end

feature -- Status report

	valid_stretch_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid stretch mode constant?
		do
			Result := c = Stretch_andscans or else
				c = Stretch_deletescans or else
				c = Stretch_orscans
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




end -- class WEL_STRETCH_MODE_CONSTANTS


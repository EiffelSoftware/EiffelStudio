indexing
	description: "Palette entry flag constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PC_CONSTANTS

feature -- Access

	Pc_reserved: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_RESERVED"
		end

	Pc_explicit: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_EXPLICIT"
		end

	Pc_nocollapse: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_NOCOLLAPSE"
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




end -- class WEL_PC_CONSTANTS


indexing
	description: "Owner Draw Action (ODA) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODA_CONSTANTS

feature -- Access

	Oda_drawentire: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_DRAWENTIRE"
		end

	Oda_select: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_SELECT"
		end

	Oda_focus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_FOCUS"
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




end -- class WEL_ODA_CONSTANTS


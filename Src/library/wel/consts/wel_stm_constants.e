indexing
	description: "Static messages (STM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STM_CONSTANTS

feature -- Access

	Stm_geticon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STM_GETICON"
		end


	Stm_getimage: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STM_GETIMAGE"
		end


	Stm_seticon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STM_SETICON"
		end


	Stm_setimage : INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STM_SETIMAGE "
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




end -- class WEL_STM_CONSTANTS


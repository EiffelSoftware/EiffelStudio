indexing
	description: "Owner Draw Type (ODT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODT_CONSTANTS

feature -- Access

	frozen Odt_menu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_MENU"
		end

	frozen Odt_listbox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_LISTBOX"
		end

	frozen Odt_combobox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_COMBOBOX"
		end

	frozen Odt_button: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_BUTTON"
		end

	frozen Odt_static: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_STATIC"
		end
		
	Odt_tab: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_TAB"
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




end -- class WEL_ODT_CONSTANTS


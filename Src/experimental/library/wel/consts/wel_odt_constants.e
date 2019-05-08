note
	description: "Owner Draw Type (ODT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODT_CONSTANTS

feature -- Access

	frozen Odt_menu: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_MENU"
		ensure
			is_class: class
		end

	frozen Odt_listbox: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_LISTBOX"
		ensure
			is_class: class
		end

	frozen Odt_combobox: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_COMBOBOX"
		ensure
			is_class: class
		end

	frozen Odt_button: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_BUTTON"
		ensure
			is_class: class
		end

	frozen Odt_static: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_STATIC"
		ensure
			is_class: class
		end

	Odt_tab: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_TAB"
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

indexing
	description: "Owner Draw Type (ODT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODT_CONSTANTS

feature -- Access

	Odt_menu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_MENU"
		end

	Odt_listbox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_LISTBOX"
		end

	Odt_combobox: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_COMBOBOX"
		end

	Odt_button: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_BUTTON"
		end

	Odt_static: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODT_STATIC"
		end

end -- class WEL_ODT_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


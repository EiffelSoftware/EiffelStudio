indexing
	description: "Owner Draw Type (ODT) constants."
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
		

end -- class WEL_ODT_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


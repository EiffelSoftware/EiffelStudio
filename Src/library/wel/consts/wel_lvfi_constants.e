indexing
	description: "Flags defining search in a list view. Used in WEL_LIST_VIEW_SEARCH_INFO"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVFI_CONSTANTS

feature -- Acess

	Lvfi_param: INTEGER is 
			-- Search item with corresponding lparam attribute
		external
			"C [macro <Commctrl.h>]: EIF_INTEGER"
		alias
			"LVFI_PARAM"
		end
	
	Lvfi_partial: INTEGER is 
			-- Search item including given string
		external
			"C [macro <Commctrl.h>]: EIF_INTEGER"
		alias
			"LVFI_PARTIAL"
		end
	
	Lvfi_string: INTEGER is 
			-- Search item with exact corresponding string
		external
			"C [macro <Commctrl.h>]: EIF_INTEGER"
		alias
			"LVFI_STRING"
		end
	
	Lvfi_wrap: INTEGER is 
			-- Start search from start when end of list view is reached
		external
			"C [macro <Commctrl.h>]: EIF_INTEGER"
		alias
			"LVFI_WRAP"
		end
	
	Lvfi_nearestxy: INTEGER is 
			-- Search item nearest specified position in specified direction
		external
			"C [macro <Commctrl.h>]: EIF_INTEGER"
		alias
			"LVFI_NEARESTXY"
		end
	
	is_valid_list_view_flag (a_flag: INTEGER): BOOLEAN is
			-- Is `a_flag' a valid list view search flag?
		do
			Result := a_flag = Lvfi_param or a_flag = Lvfi_partial
						or a_flag = Lvfi_string or a_flag = Lvfi_wrap
						or a_flag = Lvfi_nearestxy
		end
						
end -- class WEL_LVFI_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

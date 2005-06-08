indexing
	description	: "[
		Flags defining search in a list view.
		Used in WEL_LIST_VIEW_SEARCH_INFO.
		]"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVFI_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Acess

	Lvfi_param: INTEGER is 1
			-- Search item with corresponding lparam attribute
			--
			-- Declared in Windows as LVFI_PARAM

	Lvfi_partial: INTEGER is 8
			-- Search item including given string
			--
			-- Declared in Windows as LVFI_PARTIAL

	Lvfi_string: INTEGER is 2
			-- Search item with exact corresponding string
			--
			-- Declared in Windows as LVFI_STRING

	Lvfi_wrap: INTEGER is 32
			-- Start search from start when end of list view is reached
			--
			-- Declared in Windows as LVFI_WRAP

	Lvfi_nearestxy: INTEGER is 64
			-- Search item nearest specified position in specified direction
			--
			-- Declared in Windows as LVFI_NEARESTXY

feature -- Validation

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


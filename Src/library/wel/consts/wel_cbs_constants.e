indexing
	description	: "ComboBox Style (CBS) messages."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBS_CONSTANTS

feature -- Access

	Cbs_simple: INTEGER is 1
			-- Declared in Windows as CBS_SIMPLE

	Cbs_dropdown: INTEGER is 2
			-- Declared in Windows as CBS_DROPDOWN

	Cbs_dropdownlist: INTEGER is 3
			-- Declared in Windows as CBS_DROPDOWNLIST

	Cbs_ownerdrawfixed: INTEGER is 16
			-- Declared in Windows as CBS_OWNERDRAWFIXED

	Cbs_ownerdrawvariable: INTEGER is 32
			-- Declared in Windows as CBS_OWNERDRAWVARIABLE

	Cbs_autohscroll: INTEGER is 64
			-- Declared in Windows as CBS_AUTOHSCROLL

	Cbs_oemconvert: INTEGER is 128
			-- Declared in Windows as CBS_OEMCONVERT

	Cbs_sort: INTEGER is 256
			-- Declared in Windows as CBS_SORT

	Cbs_hasstrings: INTEGER is 512
			-- Declared in Windows as CBS_HASSTRINGS

	Cbs_nointegralheight: INTEGER is 1024
			-- Declared in Windows as CBS_NOINTEGRALHEIGHT

	Cbs_disablenoscroll: INTEGER is 2048
			-- Declared in Windows as CBS_DISABLENOSCROLL

end -- class WEL_CBS_CONSTANTS

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


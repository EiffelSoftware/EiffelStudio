indexing
	description	: "List view selection type constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVN_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvn_begindrag: INTEGER is -109
			-- Declared in Windows as LVN_BEGINDRAG

	Lvn_beginlabeledit: INTEGER is -105
			-- Declared in Windows as LVN_BEGINLABELEDIT

	Lvn_beginrdrag: INTEGER is -111
			-- Declared in Windows as LVN_BEGINRDRAG

	Lvn_columnclick: INTEGER is -108
			-- Declared in Windows as LVN_COLUMNCLICK

	Lvn_deleteallitems: INTEGER is -104
			-- Declared in Windows as LVN_DELETEALLITEMS

	Lvn_deleteitem: INTEGER is -103
			-- Declared in Windows as LVN_DELETEITEM

	Lvn_endlabeledit: INTEGER is -106
			-- Declared in Windows as LVN_ENDLABELEDIT

	Lvn_getdispinfo: INTEGER is -150
			-- Declared in Windows as LVN_GETDISPINFO

	Lvn_insertitem: INTEGER is -102
			-- Declared in Windows as LVN_INSERTITEM

	Lvn_itemchanged: INTEGER is -101
			-- Declared in Windows as LVN_ITEMCHANGED

	Lvn_itemchanging: INTEGER is -100
			-- Declared in Windows as LVN_ITEMCHANGING

	Lvn_keydown: INTEGER is -155
			-- Declared in Windows as LVN_KEYDOWN

	Lvn_setdispinfo: INTEGER is -151
			-- Declared in Windows as LVN_SETDISPINFO

end -- class WEL_LVN_CONSTANTS

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

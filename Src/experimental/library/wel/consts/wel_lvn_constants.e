note
	description	: "List view selection type constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVN_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvn_begindrag: INTEGER = -109
			-- Declared in Windows as LVN_BEGINDRAG

	Lvn_beginlabeledit: INTEGER = -175
			-- Declared in Windows as LVN_BEGINLABELEDIT

	Lvn_beginrdrag: INTEGER = -111
			-- Declared in Windows as LVN_BEGINRDRAG

	Lvn_columnclick: INTEGER = -108
			-- Declared in Windows as LVN_COLUMNCLICK

	Lvn_deleteallitems: INTEGER = -104
			-- Declared in Windows as LVN_DELETEALLITEMS

	Lvn_deleteitem: INTEGER = -103
			-- Declared in Windows as LVN_DELETEITEM

	Lvn_endlabeledit: INTEGER = -176
			-- Declared in Windows as LVN_ENDLABELEDIT

	Lvn_getdispinfo: INTEGER = -177
			-- Declared in Windows as LVN_GETDISPINFO

	Lvn_insertitem: INTEGER = -102
			-- Declared in Windows as LVN_INSERTITEM

	Lvn_itemchanged: INTEGER = -101
			-- Declared in Windows as LVN_ITEMCHANGED

	Lvn_itemchanging: INTEGER = -100
			-- Declared in Windows as LVN_ITEMCHANGING

	Lvn_keydown: INTEGER = -155
			-- Declared in Windows as LVN_KEYDOWN

	Lvn_setdispinfo: INTEGER = -178;
		-- Declared in Windows as LVN_SETDISPINFO

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_LVN_CONSTANTS


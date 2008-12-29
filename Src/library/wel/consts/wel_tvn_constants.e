note
	description: "Tree view notification (TVN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVN_CONSTANTS

feature -- Access

	Tvn_begindrag: INTEGER = -456
			-- Declared in Windows as TVN_BEGINDRAG

	Tvn_beginlabeledit: INTEGER = -459
			-- Declared in Windows as TVN_BEGINLABELEDIT

	Tvn_beginrdrag: INTEGER = -457
			-- Declared in Windows as TVN_BEGINRDRAG

	Tvn_deleteitem: INTEGER = -458
			-- Declared in Windows as TVN_DELETEITEM

	Tvn_endlabeledit: INTEGER = -460
			-- Declared in Windows as TVN_ENDLABELEDIT

	Tvn_getdispinfo: INTEGER = -452
			-- Declared in Windows as TVN_GETDISPINFO

	Tvn_itemexpanded: INTEGER = -455
			-- Declared in Windows as TVN_ITEMEXPANDED

	Tvn_itemexpanding: INTEGER = -454
			-- Declared in Windows as TVN_ITEMEXPANDING

	Tvn_keydown: INTEGER = -412
			-- Declared in Windows as TVN_KEYDOWN

	Tvn_selchanged: INTEGER = -451
			-- Declared in Windows as TVN_SELCHANGED

	Tvn_selchanging: INTEGER = -450
			-- Declared in Windows as TVN_SELCHANGING

	Tvn_setdispinfo: INTEGER = -453
			-- Declared in Windows as TVN_SETDISPINFO

	Tvn_getinfotip: INTEGER = -414;
			-- Declared in Windows as TVN_GETINFOTIP

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




end -- class WEL_TVN_CONSTANTS


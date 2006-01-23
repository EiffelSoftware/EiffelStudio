indexing
	description: "Tree view notification (TVN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVN_CONSTANTS

feature -- Access

	Tvn_begindrag: INTEGER is -407
			-- Declared in Windows as TVN_BEGINDRAG

	Tvn_beginlabeledit: INTEGER is -410
			-- Declared in Windows as TVN_BEGINLABELEDIT

	Tvn_beginrdrag: INTEGER is -408
			-- Declared in Windows as TVN_BEGINRDRAG

	Tvn_deleteitem: INTEGER is -409
			-- Declared in Windows as TVN_DELETEITEM

	Tvn_endlabeledit: INTEGER is -411
			-- Declared in Windows as TVN_ENDLABELEDIT

	Tvn_getdispinfo: INTEGER is -403
			-- Declared in Windows as TVN_GETDISPINFO

	Tvn_itemexpanded: INTEGER is -406
			-- Declared in Windows as TVN_ITEMEXPANDED

	Tvn_itemexpanding: INTEGER is -405
			-- Declared in Windows as TVN_ITEMEXPANDING

	Tvn_keydown: INTEGER is -412
			-- Declared in Windows as TVN_KEYDOWN

	Tvn_selchanged: INTEGER is -402
			-- Declared in Windows as TVN_SELCHANGED

	Tvn_selchanging: INTEGER is -401
			-- Declared in Windows as TVN_SELCHANGING

	Tvn_setdispinfo: INTEGER is -404
			-- Declared in Windows as TVN_SETDISPINFO

	Tvn_getinfotip: INTEGER is -413;
			-- Declared in Windows as TVN_GETINFOTIP

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




end -- class WEL_TVN_CONSTANTS


note
	description: "List View HitTest info (LVHT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVHT_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvht_above: INTEGER = 8
			-- Above the client area.
			--
			-- Declared in Windows as LVHT_ABOVE

	Lvht_below: INTEGER = 16
			-- Below the client area.
			--
			-- Declared in Windows as LVHT_BELOW

	Lvht_nowhere: INTEGER = 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as LVHT_NOWHERE

	Lvht_onitemicon: INTEGER = 2
			-- On the button associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMICON

	Lvht_onitemlabel: INTEGER = 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMLABEL

	Lvht_onitemstateicon: INTEGER = 8
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as LVHT_ONITEMSTATEICON

	Lvht_toleft: INTEGER = 64
			-- To the left of the client area.
			--
			-- Declared in Windows as LVHT_TOLEFT

	Lvht_toright: INTEGER = 32;
			-- To the right of the client area.
			--
			-- Declared in Windows as LVHT_TORIGHT

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




end -- class WEL_LVHT_CONSTANTS


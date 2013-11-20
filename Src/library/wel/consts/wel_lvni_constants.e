note
	description: "[
		List view next item (LVNI) constants.
	
		Note: Used to find items in a list view with the given properties.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVNI_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Geometric relation of the requested item to the
		-- specified item.

	Lvni_above: INTEGER = 256
			-- Searches for an item that is above the specified item.
			--
			-- Declared in Windows as LVNI_ABOVE

	Lvni_all: INTEGER = 0
			-- Searches for a subsequent item by index.
			--
			-- Declared in Windows as LVNI_ALL

	Lvni_below: INTEGER = 512
			-- Searches for an item that is below the specified item.
			--
			-- Declared in Windows as LVNI_BELOW

	Lvni_toleft: INTEGER = 1024
			-- Searches for an item to the left of the specified item.
			--
			-- Declared in Windows as LVNI_TOLEFT

	Lvni_toright: INTEGER = 2048
			-- Searches for an item to the right of the specified item.
			--
			-- Declared in Windows as LVNI_TORIGHT

feature -- State of the item

	Lvni_cut: INTEGER = 4
			-- The item has the LVIS_CUT state flag set.
			--
			-- Declared in Windows as LVNI_CUT

	Lvni_drophilited: INTEGER = 8
			-- The item has the LVIS_DROPHILITED state flag set.
			--
			-- Declared in Windows as LVNI_DROPHILITED

	Lvni_focused: INTEGER = 1
			-- The item has the LVIS_FOCUSED state flag set.
			--
			-- Declared in Windows as LVNI_FOCUSED

	Lvni_selected: INTEGER = 2;
			-- The item has the LVIS_SELECTED state flag set.
			--
			-- Declared in Windows as LVNI_SELECTED

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




end -- class WEL_LVNI_CONSTANTS


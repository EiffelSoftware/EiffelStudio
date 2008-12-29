note
	description: "Tree View HitTest info (TVHT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVHT_CONSTANTS

feature -- Access

	Tvht_above: INTEGER = 256
			-- Above the client area.
			--
			-- Declared in Windows as TVHT_ABOVE

	Tvht_below: INTEGER = 512
			-- Below the client area.
			--
			-- Declared in Windows as TVHT_BELOW

	Tvht_nowhere: INTEGER = 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as TVHT_NOWHERE

	Tvht_onitem: INTEGER = 70
			-- On the bitmap or label associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEM

	Tvht_onitembutton: INTEGER = 16
			-- On the button associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMBUTTON

	Tvht_onitemicon: INTEGER = 2
			-- On the bitmap associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMICON

	Tvht_onitemindent: INTEGER = 8
			-- In the indentation associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMINDENT

	Tvht_onitemlabel: INTEGER = 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMLABEL

	Tvht_onitemright: INTEGER = 32
			-- In the area to the right of an item.
			--
			-- Declared in Windows as TVHT_ONITEMRIGHT

	Tvht_onitemstateicon: INTEGER = 64
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as TVHT_ONITEMSTATEICON

	Tvht_toleft: INTEGER = 2048
			-- To the left of the client area.
			--
			-- Declared in Windows as TVHT_TOLEFT

	Tvht_toright: INTEGER = 1024;
			-- To the right of the client area.
			--
			-- Declared in Windows as TVHT_TORIGHT

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




end -- class WEL_BIF_CONSTANTS


indexing
	description: "Tree View HitTest info (TVHT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVHT_CONSTANTS

feature -- Access

	Tvht_above: INTEGER is 256
			-- Above the client area.
			--
			-- Declared in Windows as TVHT_ABOVE

	Tvht_below: INTEGER is 512
			-- Below the client area.
			--
			-- Declared in Windows as TVHT_BELOW

	Tvht_nowhere: INTEGER is 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as TVHT_NOWHERE

	Tvht_onitem: INTEGER is 70
			-- On the bitmap or label associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEM

	Tvht_onitembutton: INTEGER is 16
			-- On the button associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMBUTTON

	Tvht_onitemicon: INTEGER is 2
			-- On the bitmap associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMICON

	Tvht_onitemindent: INTEGER is 8
			-- In the indentation associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMINDENT

	Tvht_onitemlabel: INTEGER is 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as TVHT_ONITEMLABEL

	Tvht_onitemright: INTEGER is 32
			-- In the area to the right of an item.
			--
			-- Declared in Windows as TVHT_ONITEMRIGHT

	Tvht_onitemstateicon: INTEGER is 64
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as TVHT_ONITEMSTATEICON

	Tvht_toleft: INTEGER is 2048
			-- To the left of the client area.
			--
			-- Declared in Windows as TVHT_TOLEFT

	Tvht_toright: INTEGER is 1024
			-- To the right of the client area.
			--
			-- Declared in Windows as TVHT_TORIGHT

end -- class WEL_BIF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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


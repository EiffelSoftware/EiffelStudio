indexing
	description: "Tree View HitTest info (TVHT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVHT_CONSTANTS

feature -- Access

	Tvht_above: INTEGER is
			-- Above the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ABOVE"
		end

	Tvht_below: INTEGER is
			-- Below the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_BELOW"
		end

	Tvht_nowhere: INTEGER is
			-- In the client area, but below the last item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_NOWHERE"
		end

	Tvht_onitem: INTEGER is
			-- On the bitmap or label associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEM"
		end

	Tvht_onitembutton: INTEGER is
			-- On the button associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMBUTTON"
		end

	Tvht_onitemicon: INTEGER is
			-- On the bitmap associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMICON"
		end

	Tvht_onitemindent: INTEGER is
			-- In the indentation associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMINDENT"
		end

	Tvht_onitemlabel: INTEGER is
			-- On the label (string) associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMLABEL"
		end

	Tvht_onitemright: INTEGER is
			-- In the area to the right of an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMRIGHT"
		end

	Tvht_onitemstateicon: INTEGER is
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_ONITEMSTATEICON"
		end

	Tvht_toleft: INTEGER is
			-- To the left of the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_TOLEFT"
		end

	Tvht_toright: INTEGER is
			-- To the right of the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVHT_TORIGHT"
		end

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


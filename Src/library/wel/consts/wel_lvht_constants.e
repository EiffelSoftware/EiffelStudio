indexing
	description: "List View HitTest info (LVHT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVHT_CONSTANTS

feature -- Access

	Lvht_above: INTEGER is
			-- Above the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_ABOVE"
		end

	Lvht_below: INTEGER is
			-- Below the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_BELOW"
		end

	Lvht_nowhere: INTEGER is
			-- In the client area, but below the last item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_NOWHERE"
		end

	Lvht_onitemicon: INTEGER is
			-- On the button associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_ONITEMICON"
		end

	Lvht_onitemlabel: INTEGER is
			-- On the label (string) associated with an item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_ONITEMLABEL"
		end

	Lvht_onitemstateicon: INTEGER is
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_ONITEMSTATEICON"
		end

	Lvht_toleft: INTEGER is
			-- To the left of the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_TOLEFT"
		end

	Lvht_toright: INTEGER is
			-- To the right of the client area.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVHT_TORIGHT"
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


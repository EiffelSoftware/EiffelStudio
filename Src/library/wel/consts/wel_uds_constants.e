indexing
	description: "Up-Down control style (UDS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UDS_CONSTANTS

feature -- Access

	Uds_alignleft: INTEGER is
			-- Positions the up-down control next to the left edge
			-- of the buddy window. The buddy window is moved to the
			-- right and its width decreased to accommodate the
			-- width of the up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_ALIGNLEFT"
		end

	Uds_alignright: INTEGER is
			-- Positions the up-down control next to the right edge
			-- of the buddy window. The width of the buddy window is
			-- decreased to accommodate the width of the up-down
			-- control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_ALIGNRIGHT"
		end

	Uds_arrowkeys: INTEGER is
			-- Causes the up-down control to increment and
			-- decrement the position when the UP ARROW and DOWN
			-- ARROW keys are pressed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_ARROWKEYS"
		end

	Uds_autobuddy: INTEGER is
			-- Automatically selects the previous window in the
			-- Z order as the up-down control's buddy window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_AUTOBUDDY"
		end

	Uds_horz: INTEGER is
			-- Causes the up-down control's arrows to point left
			-- and right instead of up and down.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_HORZ"
		end

	Uds_hottrack: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_HOTTRACK"
		end

	Uds_nothousands: INTEGER is
			-- Does not insert a thousands separator between every
			-- three decimal digits.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_NOTHOUSANDS"
		end

	Uds_setbuddyint: INTEGER is
			-- Causes the up-down control to set the text of the
			-- buddy window (using the WM_SETTEXT message) when the
			-- position changes. The text consists of the position
			-- formatted as a decimal or hexadecimal string.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_SETBUDDYINT"
		end

	Uds_wrap: INTEGER is
			-- Causes the position to "wrap" if it is incremented
			-- or decremented beyond the ending or beginning of the
			-- range.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDS_WRAP"
		end

end -- class WEL_UDS_CONSTANTS

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


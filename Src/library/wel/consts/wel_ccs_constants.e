indexing
	description: "Common Control Style (CCS) constants"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CCS_CONSTANTS

feature -- Access

	Ccs_adjustable: INTEGER is
			-- Enables a toolbar's built-in customization features,
			-- which allow the user to drag a button to a new
			-- position or to remove a button by dragging it off
			-- the toolbar. In addition, the user can double-click
			-- the toolbar to display the Customize Toolbar dialog
			-- box, allowing the user to add, delete, and
			-- rearrange toolbar buttons.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_ADJUSTABLE"
		end

	Ccs_bottom: INTEGER is
			-- Causes the control to position itself at the bottom
			-- of the parent window's client area and sets the
			-- width to be the same as the parent window's width.
			-- Status windows have this style by default.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_BOTTOM"
		end

	Ccs_nodivider: INTEGER is
			-- Prevents a two-pixel highlight from being drawn at
			-- the top of the control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_NODIVIDER"
		end

	-- Not defined in `commctrl.h'.
	--Ccs_nohilite: INTEGER is
			-- Prevents a one-pixel highlight from being drawn at
			-- the top of the control.
		--external
			--"C [macro %"cctrl.h%"]"
		--alias
			--"CCS_NOHILITE"
		--end

	Ccs_nomovey: INTEGER is
			-- Causes the control to resize and move itself
			-- horizontally, but not vertically, in response to a
			-- Wm_size message. If Ccs_noresize is used, this
			-- style does not apply. Header windows have this style
			-- by default.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_NOMOVEY"
		end

	Ccs_noparentalign: INTEGER is
			-- Prevents the control from automatically moving to
			-- the top or bottom of the parent window. Instead, the
			-- control keeps its position within the parent window
			-- despite changes to the size of the parent. If
			-- Ccs_top or Ccs_bottom is also used, the height is
			-- adjusted to the default, but the position and width
			-- remain unchanged.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_NOPARENTALIGN"
		end

	Ccs_noresize: INTEGER is
			-- Prevents the control from using the default width
			-- and height when setting its initial size or a new
			-- size. Instead, the control uses the width and
			-- height specified in the request for creation or
			-- sizing.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_NORESIZE"
		end

	Ccs_top: INTEGER is
			-- Causes the control to position itself at the top of
			-- the parent window's client area and sets the width
			-- to be the same as the parent window's width.
			-- Toolbars have this style by default.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CCS_TOP"
		end

end -- class WEL_CCS_CONSTANTS

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


indexing
	description: "Toolbar style constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TB_STYLE_CONSTANTS

feature -- Access

-- A toolbar can have a combination of the following styles.

	Tbstyle_altdrag: INTEGER is
			-- Allows the user to change the position of a toolbar
			-- button by dragging it while holding down the ALT key.
			-- If this style is not specified, the user must hold
			-- down the SHIFT key while dragging a button. Note
			-- that the Ccs_adjustable style must be specified to
			-- enable toolbar buttons to be dragged.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_ALTDRAG"
		end

	Tbstyle_tooltips: INTEGER is
			-- Creates a tooltip control that an application can
			-- use to display descriptive text for the buttons in
			-- the toolbar.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_TOOLTIPS"
		end

	Tbstyle_wrapable: INTEGER is
			-- Creates a toolbar that can have multiple lines of
			-- buttons. Toolbar buttons can "wrap" to the next
			-- line when the toolbar becomes too narrow to include
			-- all buttons on the same line. Wrapping occurs on
			-- separation and non-group boundaries.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_WRAPABLE"
		end

-- A button in a toolbar can have a combination of the following styles.

	Tbstyle_button: INTEGER is
			-- Creates a standard push button. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_BUTTON"
		end

	Tbstyle_check: INTEGER is
			-- Creates a button that toggles between the pressed
			-- and not pressed states each time the user clicks it.
			-- The button has a different background color when it
			-- is in the pressed state.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_CHECK"
		end

	Tbstyle_checkgroup: INTEGER is
			-- Creates a check button that stays pressed until
			-- another button in the group is pressed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_CHECKGROUP"
		end

	Tbstyle_group: INTEGER is
			-- Creates a button that stays pressed until another
			-- button in the group is pressed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_GROUP"
		end

	Tbstyle_sep: INTEGER is
			-- Creates a separator, providing a small gap between
			-- button groups. A button that has this style does not
			-- receive user input.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBSTYLE_SEP"
		end

end -- class WEL_TB_STYLE_CONSTANTS

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


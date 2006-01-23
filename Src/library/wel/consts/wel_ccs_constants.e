indexing
	description: "Common Control Style (CCS) constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CCS_CONSTANTS

feature -- Access

	Ccs_adjustable: INTEGER is 32
			-- Enables a toolbar's built-in customization features,
			-- which allow the user to drag a button to a new
			-- position or to remove a button by dragging it off
			-- the toolbar. In addition, the user can double-click
			-- the toolbar to display the Customize Toolbar dialog
			-- box, allowing the user to add, delete, and
			-- rearrange toolbar buttons.

	Ccs_bottom: INTEGER is 3
			-- Causes the control to position itself at the bottom
			-- of the parent window's client area and sets the
			-- width to be the same as the parent window's width.
			-- Status windows have this style by default.

	Ccs_nodivider: INTEGER is 64
			-- Prevents a two-pixel highlight from being drawn at
			-- the top of the control.

	Ccs_nomovey: INTEGER is 2
			-- Causes the control to resize and move itself
			-- horizontally, but not vertically, in response to a
			-- Wm_size message. If Ccs_noresize is used, this
			-- style does not apply. Header windows have this style
			-- by default.

	Ccs_noparentalign: INTEGER is 8
			-- Prevents the control from automatically moving to
			-- the top or bottom of the parent window. Instead, the
			-- control keeps its position within the parent window
			-- despite changes to the size of the parent. If
			-- Ccs_top or Ccs_bottom is also used, the height is
			-- adjusted to the default, but the position and width
			-- remain unchanged.

	Ccs_noresize: INTEGER is 4
			-- Prevents the control from using the default width
			-- and height when setting its initial size or a new
			-- size. Instead, the control uses the width and
			-- height specified in the request for creation or
			-- sizing.

	Ccs_top: INTEGER is 1;
			-- Causes the control to position itself at the top of
			-- the parent window's client area and sets the width
			-- to be the same as the parent window's width.
			-- Toolbars have this style by default.

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




end -- class WEL_CCS_CONSTANTS


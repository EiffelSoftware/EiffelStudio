indexing
	description	: "Toolbar style (TB_STYLE...) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TB_STYLE_CONSTANTS


feature -- Access

-- A toolbar can have a combination of the following styles.

	Tbstyle_altdrag: INTEGER is 1024
			-- Allows the user to change the position of a toolbar
			-- button by dragging it while holding down the ALT key.
			-- If this style is not specified, the user must hold
			-- down the SHIFT key while dragging a button. Note
			-- that the Ccs_adjustable style must be specified to
			-- enable toolbar buttons to be dragged.

	Tbstyle_tooltips: INTEGER is 256
			-- Creates a tooltip control that an application can
			-- use to display descriptive text for the buttons in
			-- the toolbar.

	Tbstyle_wrapable: INTEGER is 512
			-- Creates a toolbar that can have multiple lines of
			-- buttons. Toolbar buttons can "wrap" to the next
			-- line when the toolbar becomes too narrow to include
			-- all buttons on the same line. Wrapping occurs on
			-- separation and non-group boundaries.

	Tbstyle_flat: INTEGER is 2048
			-- Creates a transparent toolbar with flat buttons.
			-- The apparence of the button change when the user
			-- move the mouse on the button.

	Tbstyle_list: INTEGER is 4096
			-- Places button text to the right of button bitmaps.
			-- To avoid repainting problems, this style should be
			-- set before the toolbar control becomes visible.

	Tbstyle_customerase: INTEGER is 8192
			-- Generates NM_CUSTOMDRAW notification messages when
			-- it processes WM_ERASEBKGND.

-- A button in a toolbar can have a combination of the following styles.

	Tbstyle_button: INTEGER is 0
			-- Creates a standard push button. 

	Tbstyle_check: INTEGER is 2
			-- Creates a button that toggles between the pressed
			-- and not pressed states each time the user clicks it.
			-- The button has a different background color when it
			-- is in the pressed state.

	Tbstyle_checkgroup: INTEGER is 6
			-- Creates a check button that stays pressed until
			-- another button in the group is pressed.

	Tbstyle_group: INTEGER is 4
			-- Creates a button that stays pressed until another
			-- button in the group is pressed.

	Tbstyle_sep: INTEGER is 1
			-- Creates a separator, providing a small gap between
			-- button groups. A button that has this style does not
			-- receive user input.

	Tbstyle_dropdown: INTEGER is 8
			-- Creates a drop-down list button. If the toolbar has
			-- the TBSTYLE_EX_DRAWDDARROWS extended style, an arrow
			-- will be displayed next to the button.

end -- class WEL_TB_STYLE_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


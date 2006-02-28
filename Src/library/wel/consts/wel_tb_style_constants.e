indexing
	description	: "Toolbar style (TB_STYLE...) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Tbstyle_transparent: INTEGER is 0x00008000
			-- Version 4.71. Creates a transparent toolbar. In a transparent toolbar,
			-- the toolbar is transparent but the buttons are not. Button text appears
			-- under button bitmaps. To prevent repainting problems, this style should
			-- be set before the toolbar control becomes visible.

-- A button in a toolbar can have a combination of the following styles.

	Tbstyle_button: INTEGER is 0
			-- Creates a standard push button.

	Tbstyle_check: INTEGER is 2
			-- Creates a button that toggles between the pressed
			-- and not pressed states each time the user clicks it.
			-- The button has a different background color when it
			-- is in the pressed state.

	Tbstyle_autosize: INTEGER is 16
			-- The toolbar will not assign the standard width to
			-- the button. Instead, the buttons width will be calculated
			-- based on the width of the text plus the image of the
			-- button.

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

feature -- Tool bar button styles

	Btns_showtext: INTEGER is 0x40
			-- Version 5.81. Specifies that button text should be
			-- displayed. All buttons can have text, but only those
			-- buttons with the BTNS_SHOWTEXT button style will
			-- display it. This button style must be used with the
			-- TBSTYLE_LIST style and the TBSTYLE_EX_MIXEDBUTTONS
			-- extended style. If you set text for buttons that do
			-- not have the BTNS_SHOWTEXT style, the toolbar control
			-- will automatically display it as a ToolTip when the
			-- cursor hovers over the button. This feature allows your
			-- application to avoid handling the TBN_GETINFOTIP
			-- notification for the toolbar.

	Btns_dropdown: INTEGER is 0x08
			-- Version 5.80. Creates a drop-down style button that
			-- can display a list when the button is clicked. Instead
			-- of the WM_COMMAND message used for normal buttons,
			-- drop-down buttons send a TBN_DROPDOWN notification.
			-- An application can then have the notification handler
			-- display a list of options. Use the equivalent style
			-- flag, TBSTYLE_DROPDOWN, for version 4.72 and earlier.

			-- If the toolbar has the TBSTYLE_EX_DRAWDDARROWS extended
			-- style, drop-down buttons will have a drop-down arrow
			-- displayed in a separate section to their right. If the
			-- arrow is clicked, a TBN_DROPDOWN notification will be
			-- sent. If the associated button is clicked, a WM_COMMAND
			-- message will be sent.

	Btns_autosize: INTEGER is 0x10
			-- Version 5.80. Specifies that the toolbar control should
			-- not assign the standard width to the button. Instead,
			-- the button's width will be calculated based on the width
			-- of the text plus the image of the button.
			-- Use the equivalent style flag, TBSTYLE_AUTOSIZE, for
			-- version 4.72 and earlier.

feature -- Tool bar extended styles

	Tbstyle_ex_drawddarrows: INTEGER is 0x00000001
			-- Version 4.71. This style allows buttons to have a separate
			-- dropdown arrow. Buttons that have the BTNS_DROPDOWN style
			-- will be drawn with a drop-down arrow in a separate section,
			-- to the right of the button. If the arrow is clicked, only
			-- the arrow portion of the button will depress, and the toolbar
			-- control will send a TBN_DROPDOWN notification to prompt the
			-- application to display the dropdown menu. If the main part
			-- of the button is clicked, the toolbar control sends a
			-- WM_COMMAND message with the button's ID. The application
			-- normally responds by launching the first command on the menu.

			-- There are many situations where you may want to have only
			-- some of the dropdown buttons on a toolbar with separated.
			-- To do so, set the TBSTYLE_EX_DRAWDDARROWS extended style.
			-- Give those buttons that will not have separated arrows the
			-- BTNS_WHOLEDROPDOWN style. Buttons with this style will have
			-- an arrow displayed next to the image. However, the arrow will
			-- not be separate and when any part of the button is clicked,
			-- the toolbar control will send a TBN_DROPDOWN notification.
			-- To prevent repainting problems, this style should be set
			-- before the toolbar control becomes visible.

	Tbstyle_ex_hideclippedbuttons: INTEGER is 0x00000010
			-- Version 5.81. This style hides partially clipped buttons.
			-- The most common use of this style is for toolbars that are
			-- part of a rebar control. If an adjacent band covers part of
			-- a button, the button will not be displayed. However, if the
			-- rebar band has the RBBS_USECHEVRON style, the button will be
			-- displayed on the chevron's dropdown menu.

	Tbstyle_ex_doublebuffer: INTEGER is 0x00000080
			--  Version 6. This style requires the toolbar to be double
			-- buffered. Double buffering is a mechanism that detects when
			-- the toolbar has changed.
			-- Note  Comctl32.dll version 6 is not redistributable but it
			-- is included in Microsoft Windows XP or later. To use
			-- Comctl32.dll version 6, specify it in a manifest. For more
			-- information on manifests, see Using Windows XP Visual Styles.

	Tbstyle_ex_mixedbuttons: INTEGER is 0x00000008;
			-- Version 5.81. This style allows you to set text for all
			-- buttons, but only display it for those buttons with the
			-- BTNS_SHOWTEXT button style. The TBSTYLE_LIST style must also
			-- be set. Normally, when a button does not display text, your
			-- application must handle TBN_GETINFOTIP to display a ToolTip.
			-- With the TBSTYLE_EX_MIXEDBUTTONS extended style, text that
			-- is set but not displayed on a button will automatically be
			-- used as the button's ToolTip text. Your application only
			-- needs to handle TBN_GETINFOTIP if it needs more flexibility
			-- in specifying the ToolTip text.

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




end -- class WEL_TB_STYLE_CONSTANTS


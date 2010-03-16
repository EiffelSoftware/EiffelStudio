note
	description: "Tab control style (TCS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCS_CONSTANTS

feature -- Styles

	Tcs_bottom: INTEGER = 2
			-- Version 4.70. 
			-- Tabs appear at the bottom of the control. This value equals
			-- TCS_RIGHT.
			--
			-- Declared in Windows as TCS_BOTTOM

	Tcs_buttons: INTEGER = 256
			-- Tabs appear as buttons, and no border is drawn around the
			-- display area.
			--
			-- Declared in Windows as TCS_BUTTONS

	Tcs_fixedwidth: INTEGER = 1024
			-- All tabs are the same width. This style cannot be combined with
			-- the TCS_RIGHTJUSTIFY style.
			--
			-- Declared in Windows as TCS_FIXEDWIDTH

	Tcs_flatbuttons: INTEGER = 8
			-- Version 4.71. 
			-- Selected tabs appear as being indented into the background while
			-- other tabs appear as being on the same plane as the background. 
			-- This style only affects tab controls with the TCS_BUTTONS style.
			--
			-- Declared in Windows as TCS_FLATBUTTONS

	Tcs_focusnever: INTEGER = 32768
			-- The tab control does not receive the input focus when clicked.
			--
			-- Declared in Windows as TCS_FOCUSNEVER

	Tcs_focusonbuttondown: INTEGER = 4096
			-- The tab control receives the input focus when clicked.
			--
			-- Declared in Windows as TCS_FOCUSONBUTTONDOWN

	Tcs_forceiconleft: INTEGER = 16
			-- Icons are aligned with the left edge of each fixed-width tab.
			-- This style can only be used with the TCS_FIXEDWIDTH style.
			--
			-- Declared in Windows as TCS_FORCEICONLEFT

	Tcs_forcelabelleft: INTEGER = 32
			-- Labels are aligned with the left edge of each fixed-width tab;
			-- that is, the label is displayed immediately to the right of
			-- the icon instead of being centered.
			-- This style can only be used with the TCS_FIXEDWIDTH style,
			-- and it implies the TCS_FORCEICONLEFT style.
			--
			-- Declared in Windows as TCS_FORCELABELLEFT

	Tcs_hottrack: INTEGER = 64
			-- Version 4.70.
			-- Items under the pointer are automatically highlighted. You 
			-- can check whether or not hot tracking is enabled by calling 
			-- SystemParametersInfo. 
			--
			-- Declared in Windows as TCS_HOTTRACK

	Tcs_multiline: INTEGER = 512
			-- Multiple rows of tabs are displayed, if necessary, so all
			-- tabs are visible at once.
			--
			-- Declared in Windows as TCS_MULTILINE

	Tcs_multiselect: INTEGER = 4
			-- Version 4.70.
			-- Multiple tabs can be selected by holding down CTRL when
			-- clicking. This style must be used with the TCS_BUTTONS style.
			--
			-- Declared in Windows as TCS_MULTISELECT

	Tcs_ownerdrawfixed: INTEGER = 8192
			-- The parent window is responsible for drawing tabs.
			--
			-- Declared in Windows as TCS_OWNERDRAWFIXED

	Tcs_raggedright: INTEGER = 2048
			-- Rows of tabs will not be stretched to fill the entire width of
			-- the control. This style is the default.
			--
			-- Declared in Windows as TCS_RAGGEDRIGHT

	Tcs_right: INTEGER = 2
			-- Version 4.70. Tabs appear vertically on the right side of
			-- controls that use the TCS_VERTICAL style. This value equals
			-- TCS_BOTTOM.
			--
			-- Declared in Windows as TCS_RIGHT

	Tcs_rightjustify: INTEGER = 0
			-- The width of each tab is increased, if necessary, so that each
			-- row of tabs fills the entire width of the tab control.
			-- This window style is ignored unless the TCS_MULTILINE style is
			-- also specified.
			--
			-- Declared in Windows as TCS_RIGHTJUSTIFY

	Tcs_scrollopposite: INTEGER = 1
			-- Version 4.70. 
			-- Unneeded tabs scroll to the opposite side of the control when
			-- a tab is selected.
			--
			-- Declared in Windows as TCS_SCROLLOPPOSITE

	Tcs_singleline: INTEGER = 0
			-- Only one row of tabs is displayed. The user can scroll to see
			-- more tabs, if necessary. This style is the default.
			--
			-- Declared in Windows as TCS_SINGLELINE

	Tcs_tabs: INTEGER = 0
			-- Tabs appear as tabs, and a border is drawn around the display
			-- area. This style is the default.
			--
			-- Declared in Windows as TCS_TABS

	Tcs_tooltips: INTEGER = 16384
			-- The tab control has a tooltip control associated with it. 
			--
			-- Declared in Windows as TCS_TOOLTIPS

	Tcs_vertical: INTEGER = 128
			-- Version 4.70.
			-- Tabs appear at the left side of the control, with tab text
			-- displayed vertically. This style is valid only when used with
			-- the TCS_MULTILINE style. To make tabs appear on the right side
			-- of the control, also use the TCS_RIGHT style.
			--
			-- Declared in Windows as TCS_VERTICAL

feature -- Extended Styles

	Tcs_ex_flatseparators: INTEGER = 1
			-- Version 4.71.
			-- The tab control will draw separators between the tab items.
			-- This extended style only affects tab controls that have the 
			-- TCS_BUTTONS and TCS_FLATBUTTONS styles. By default, creating
			-- the tab control with the TCS_FLATBUTTONS style sets this 
			-- extended style. If you do not require separators, you should
			-- remove this extended style after creating the control.
			--
			-- Declared in Windows as TCS_EX_FLATSEPARATORS

	Tcs_ex_registerdrop: INTEGER = 2;
			-- Version 4.71.
			-- The tab control generates TCN_GETOBJECT notification messages
			-- to request a drop target object when an object is dragged over
			-- the tab items in the control. The application must call 
			-- CoInitialize or OleInitialize before setting this style. 
			--
			-- Declared in Windows as TCS_EX_REGISTERDROP

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




end -- class WEL_TCS_CONSTANTS


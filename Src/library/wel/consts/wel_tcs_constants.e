indexing
	description: "Tab control style (TCS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCS_CONSTANTS

feature -- Access

	Tcs_buttons: INTEGER is
			-- Specifies that tabs appear as buttons and no border
			-- is drawn around the display area.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_BUTTONS"
		end

	Tcs_fixedwidth: INTEGER is
			-- Specifies that all tabs are the same width. This
			-- style cannot be combined with the TCS_RIGHTJUSTIFY
			-- style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_FIXEDWIDTH"
		end

	Tcs_focusnever: INTEGER is
			-- Specifies that the tab control never receives the
			-- input focus.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_FOCUSNEVER"
		end

	Tcs_focusonbuttondown: INTEGER is
			-- Specifies that tabs receive the input focus when
			-- clicked.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_FOCUSONBUTTONDOWN"
		end

	Tcs_forceiconleft: INTEGER is
			-- Aligns icons with the left edge of each fixed-width
			-- tab. This style can only be used with the
			-- TCS_FIXEDWIDTH style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_FORCEICONLEFT"
		end

	Tcs_forcelabelleft: INTEGER is
			-- Aligns labels with the left edge of each fixed-width
			-- tab; that is, it displays the label immediately to
			-- the right of the icon instead of centering it. This
			-- style can only be used with the TCS_FIXEDWIDTH style,
			-- and it implies the TCS_FORCEICONLEFT style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_FORCELABELLEFT"
		end

	Tcs_multiline: INTEGER is
			-- Displays multiple rows of tabs, if necessary, so all
			-- tabs are visible at once.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_MULTILINE"
		end

	Tcs_ownerdrawfixed: INTEGER is
			-- Specifies that the parent window is responsible for
			-- drawing tabs.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_OWNERDRAWFIXED"
		end

	Tcs_raggedright: INTEGER is
			-- Does not stretch each row of tabs to fill the entire
			-- width of the control. This style is the default.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_RAGGEDRIGHT"
		end

	Tcs_rightjustify: INTEGER is
			-- Increases the width of each tab, if necessary, so
			-- that each row of tabs fills the entire width of the
			-- tab control. This window style is ignored unless the
			-- TCS_MULTILINE style is also specified.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_RIGHTJUSTIFY"
		end

	Tcs_singleline: INTEGER is
			-- Displays only one row of tabs. The user can scroll
			-- to see more tabs, if necessary. This style is the
			-- default.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_SINGLELINE"
		end

	Tcs_tabs: INTEGER is
			-- Specifies that tabs appear as tabs and that a border
			-- is drawn around the display area. This style is the
			-- default.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_TABS"
		end

	Tcs_tooltips: INTEGER is
			-- Specifies that the tab control has a tooltip control
			-- associated with it. For more information about
			-- tooltip controls.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_TOOLTIPS"
		end

	Tcs_scrollopposite: INTEGER is
			-- Undocmented style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_SCROLLOPPOSITE"
		end

	Tcs_bottom: INTEGER is
			-- Undocmented style.
			-- Set the tabs at the bottom of the notebook.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_BOTTOM"
		end

	Tcs_right: INTEGER is
			-- Undocmented style.
			-- Set the tabs at the right of the notebook.
			-- Need `Tcs_vertical' style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_RIGHT"
		end

	Tcs_hottrack: INTEGER is
			-- Undocmented style.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_HOTTRACK"
		end

	Tcs_vertical: INTEGER is
			-- Undocmented style.
			-- Set the tabs verticaly at the left of the 
			-- notebook.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCS_VERTICAL"
		end

end -- class WEL_TCS_CONSTANTS

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


indexing
	description: "Dialog style (DS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DS_CONSTANTS

feature -- Constants

	Ds_absalign: INTEGER is 1
			-- Indicates that the coordinates of the dialog box are screen
			-- coordinates. If this style is not specified, the coordinates
			-- are client coordinates.

	Ds_setfont: INTEGER is 64
			-- User specified font for Dlg controls.

	Ds_modalframe: INTEGER is 128
			-- Creates a dialog box with a modal dialog-box frame that can be
			-- combined with a title bar and window menu by specifying the
			-- Ws_caption and Ws_sysmenu styles. (See: WEL_WS_CONSTANTS).

	Ds_noidlemsg: INTEGER is 256
			-- Wm_enteridle message will not be sent.

	Ds_setforeground: INTEGER is 512
			-- Causes the system to use the SetForegroundWindow function to
			-- bring the dialog box to the foreground. This style is useful
			-- for modal dialog boxes that require immediate attention from
			-- the user regardless of whether the owner window is the
			-- foreground window.

end -- class WEL_DS_CONSTANTS


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


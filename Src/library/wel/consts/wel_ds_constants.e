indexing
	description: "Dialog style (DS) constants."
	legal: "See notice at end of class."
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
			
	Ds_centermouse: INTEGER is 4096
			-- Centers the dialog box on the mouse cursor.

	Ds_setfont: INTEGER is 64
			-- User specified font for Dlg controls.

	Ds_modalframe: INTEGER is 128
			-- Creates a dialog box with a modal dialog-box frame that can be
			-- combined with a title bar and window menu by specifying the
			-- Ws_caption and Ws_sysmenu styles. (See: WEL_WS_CONSTANTS).
			
	Ds_control: INTEGER is 1024
			-- Creates a dialog box that works well as a child window of another
			-- dialog box, much like a page in a property sheet. This style
			-- allows the user to tab among the control windows of a child dialog
			-- box, use its accelerator keys, and so on.

	Ds_noidlemsg: INTEGER is 256
			-- Wm_enteridle message will not be sent.

	Ds_setforeground: INTEGER is 512;
			-- Causes the system to use the SetForegroundWindow function to
			-- bring the dialog box to the foreground. This style is useful
			-- for modal dialog boxes that require immediate attention from
			-- the user regardless of whether the owner window is the
			-- foreground window.

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




end -- class WEL_DS_CONSTANTS


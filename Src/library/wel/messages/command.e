indexing
	description: "Information about message Wm_command which is sent when %
		%the user selects a command item from a menu, when a control %
		%sends a notification message to its parent window, or when an %
		%accelerator keystroke is translated."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

creation
	make

feature -- Access

	id: INTEGER is
			-- Identifier of the menu item, control, or accelerator.
		do
			Result := cwin_get_wm_command_id (w_param, l_param)
		end

	control: WEL_CONTROL is
			-- Control sending the message if the message is from a
			-- control.
		require
			from_control: from_control
		do
			Result ?= windows.item (h_window)
		end

	notify_code: INTEGER is
			-- Notification message
		do
			Result := cwin_get_wm_command_cmd (w_param, l_param)
		end

	h_window: POINTER is
			-- Handle of control
		do
			Result := cwin_get_wm_command_hwnd (w_param, l_param)
		end

feature -- Status report

	from_control: BOOLEAN is
			-- Does the message come from a control?
		do
			Result := h_window /= default_pointer
		end

	from_menu: BOOLEAN is
			-- Does the message come from a menu?
		do
			Result := notify_code = 0
		end

	from_accelerator: BOOLEAN is
			-- Does the message come from an accelerator?
		do
			Result := notify_code = 1
		end

feature {NONE} -- Externals

	cwin_get_wm_command_cmd (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_CMD"
		end

	cwin_get_wm_command_id (wparam, lparam: INTEGER): INTEGER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_ID"
		end

	cwin_get_wm_command_hwnd (wparam, lparam: INTEGER): POINTER is
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_COMMAND_HWND"
		end

end -- class WEL_COMMAND_MESSAGE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

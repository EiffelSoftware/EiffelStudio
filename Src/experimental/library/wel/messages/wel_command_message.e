note
	description: "Information about message Wm_command which is sent when %
		%the user selects a command item from a menu, when a control %
		%sends a notification message to its parent window, or when an %
		%accelerator keystroke is translated."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

create
	make

feature -- Access

	id: INTEGER
			-- Identifier of the menu item, control, or accelerator.
		do
			Result := cwin_get_wm_command_id (w_param, l_param)
		end

	control: detachable WEL_CONTROL
			-- Control sending the message if the message is from a
			-- control.
		require
			from_control: from_control
		do
			Result ?= window_of_item (h_window)
		end

	notify_code: INTEGER
			-- Notification message
		do
			Result := cwin_get_wm_command_cmd (w_param, l_param)
		end

	h_window: POINTER
			-- Handle of control
		do
			Result := cwin_get_wm_command_hwnd (w_param, l_param)
		end

feature -- Status report

	from_control: BOOLEAN
			-- Does the message come from a control?
		do
			Result := h_window /= default_pointer
		end

	from_menu: BOOLEAN
			-- Does the message come from a menu?
		do
			Result := notify_code = 0
		end

	from_accelerator: BOOLEAN
			-- Does the message come from an accelerator?
		do
			Result := notify_code = 1
		end

feature {NONE} -- Externals

	cwin_get_wm_command_cmd (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_CMD"
		end

	cwin_get_wm_command_id (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_ID"
		end

	cwin_get_wm_command_hwnd (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_COMMAND_HWND"
		end

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




end -- class WEL_COMMAND_MESSAGE


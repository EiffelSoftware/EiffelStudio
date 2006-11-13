indexing
	description: "Set of Win32 API that can be statically accessed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_API

feature -- Windows

	frozen window_from_point (point: POINTER): POINTER is
			-- SDK WindowFromPoint
		external
			"C inline use <windows.h>"
		alias
			"WindowFromPoint (* ((POINT*) $point))"
		end

	frozen child_window_from_point (hwnd_parent: POINTER; point: POINTER): POINTER is
			-- SDK ChildWindowFromPoint
		external
			"C inline use <windows.h>"
		alias
			"ChildWindowFromPoint ((HWND) $hwnd_parent, * ((POINT*) $point))"
		end

feature -- Menus

	frozen set_menu (hwnd, hmenu: POINTER): INTEGER is
			-- SDK SetMenu
		external
			"C inline use <windows.h>"
		alias
			"SetMenu ((HWND) $hwnd, (HMENU) $hmenu)"
		end

	frozen track_popup_menu (hmenu: POINTER; flags, x, y, reserved: INTEGER; hwnd, rect: POINTER) is
			-- SDK TrackPopupMenu
		external
			"C inline use <windows.h>"
		alias
			"TrackPopupMenu((HMENU) $hmenu, (UINT) $flags, (int) $x, (int) $y, (int) $reserved, (HWND) $hwnd, (RECT *) $rect)"
		end

	frozen get_menu (hwnd: POINTER): POINTER is
			-- SDK GetMenu
		external
			"C inline use <windows.h>"
		alias
			"GetMenu ((HWND) $hwnd)"
		end

	frozen get_menu_bar_info (hwnd: POINTER; id_object, id_item: INTEGER; menu_bar_info: POINTER): INTEGER is
			-- SDK GetMenuBarInfo
		external
			"C inline use <windows.h>"
		alias
			"GetMenuBarInfo((HWND) $hwnd, (LONG) $id_object, (LONG) $id_item, (PMENUBARINFO) $menu_bar_info)"
		end

	frozen get_menu_item_rect (hwnd, hmenu: POINTER; uitem: INTEGER; rect: POINTER): INTEGER is
			-- SDK GetMenuItemRect
		external
			"C inline use <windows.h>"
		alias
			"GetMenuItemRect((HWND) $hwnd, (HMENU) $hmenu, (UINT) $uitem, (RECT *) $rect)"
		end

feature -- Messages

	frozen post_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): BOOLEAN is
			-- SDK PostMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	frozen post_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER) is
			-- SDK PostMessage (without the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	frozen register_window_message (a_message_name: POINTER): INTEGER is
			-- Register a custom window message named `message_name'.
			-- `Result' is id of new message.
		external
			"C inline use <windows.h>"
		alias
			"RegisterWindowMessage ((LPCTSTR) $a_message_name)"
		end

	frozen send_message_result (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: POINTER): BOOLEAN is
			-- SDK SendMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	frozen send_message_integer_result (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: POINTER): INTEGER is
			-- SDK SendMessage (with an integer result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	frozen send_message (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: POINTER) is
			-- SDK SendMessage
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

feature -- Windows

	frozen set_foreground_window (hwnd: POINTER): BOOLEAN is
			-- The SetForegroundWindow function puts the thread that created the specified
			-- window into the foreground and activates the window. Keyboard input is
			-- directed to the window, and various visual cues are changed for the user.
			-- The system assigns a slightly higher priority to the thread that created
			-- the foreground window than it does to other threads.
		external
			"C inline use <windows.h>"
		alias
			"SetForegroundWindow ((HWND)$hwnd)"
		end

feature -- Shell

	frozen shell_notify_icon (a_message: INTEGER; a_notify_icon_data_ptr: POINTER): INTEGER is
			-- Sends a message to the taskbar's status area.
		external
			"C inline use <shellapi.h>"
		alias
			"Shell_NotifyIcon((DWORD) $a_message, (PNOTIFYICONDATA) $a_notify_icon_data_ptr)"
		end

feature -- Character codes

	frozen vk_key_scan (a_char: CHARACTER_32): INTEGER_32 is
			-- Given a character `a_char' gives us the key that triggers its generation.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER_32) VkKeyScan ((TCHAR) $a_char);"
		end

feature -- Error

	frozen get_last_error: INTEGER is
			-- SDK GetLastError

		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER_32)GetLastError()"
		end

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




end

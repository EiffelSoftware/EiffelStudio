indexing
	description: "Set of Win32 API that can be statically accessed."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_API

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

feature -- Messages

	frozen post_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
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
			"RegisterWindowMessage ((LPCSTR) $a_message_name)"
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

end

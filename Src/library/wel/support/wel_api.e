note
	description: "Set of Win32 API that can be statically accessed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_API

feature -- Windows

	window_from_point (point: POINTER): POINTER
			-- SDK WindowFromPoint
		external
			"C inline use <windows.h>"
		alias
			"WindowFromPoint (* ((POINT*) $point))"
		end

	child_window_from_point (hwnd_parent: POINTER; point: POINTER): POINTER
			-- SDK ChildWindowFromPoint
		external
			"C inline use <windows.h>"
		alias
			"ChildWindowFromPoint ((HWND) $hwnd_parent, * ((POINT*) $point))"
		end

	set_foreground_window (hwnd: POINTER): BOOLEAN
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

	set_window_text (hwnd, str: POINTER)
			-- SDK SetWindowText
		external
			"C inline use <windows.h>"
		alias
			"SetWindowText ((HWND)$hwnd, (LPCTSTR)$str)"
		end

	set_parent (hwnd_child, hwnd_parent: POINTER): POINTER
			-- Change the parent of the given child and return handle to
			-- previous parent, or NULL otherwise.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) SetParent ((HWND) $hwnd_child, (HWND) $hwnd_parent);"
		end

	move_window (hwnd: POINTER; a_x, a_y, a_w, a_h: INTEGER; repaint: BOOLEAN): BOOLEAN
			-- SDK MoveWindow
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(MoveWindow((HWND) $hwnd, (int) $a_x, (int) $a_y, (int) $a_w, (int) $a_h, (BOOL) $repaint));"
		end

	set_window_pos (hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h, flags: INTEGER): BOOLEAN
			-- SDK SetWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(SetWindowPos((HWND) $hwnd, (HWND) $hwnd_after, (int) $a_x, (int) $a_y, (int) $a_w, (int) $a_h, (UINT) $flags));"
		end

	begin_defer_window_pos (n: INTEGER): POINTER
			-- SDK BeginDeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return BeginDeferWindowPos((int) $n);"
		end

	defer_window_pos (hdwp, hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h, flags: INTEGER): POINTER
			-- SDK DeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return DeferWindowPos((HDWP) $hdwp, (HWND) $hwnd, (HWND) $hwnd_after, (int) $a_x, (int) $a_y, (int) $a_w, (int) $a_h, (UINT) $flags);"
		end

	end_defer_window_pos (hdwp: POINTER): BOOLEAN
			-- SDK EndDeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(EndDeferWindowPos((HDWP) $hdwp));"
		end

	get_focus: POINTER
			-- SDK GetFocus
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetFocus();"
		end

	get_parent (a_hwnd: POINTER): POINTER
			-- SDK GetParent
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetParent((HWND) $a_hwnd);"
		end

	destroy_window (hwnd: POINTER): BOOLEAN
			-- SDK DestroyWindow
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(DestroyWindow((HWND) $hwnd));"
		end

feature -- Multi-monitor

	monitor_from_rect (a_rect: POINTER; a_flags: INTEGER_32): POINTER
			-- SDK MonitorFromRect
		external
			"C inline use <windows.h>"
		alias
			"MonitorFromRect((LPCRECT) $a_rect, (DWORD) $a_flags)"
		end

	monitor_from_window (a_hwnd: POINTER; a_flags: INTEGER_32): POINTER
			-- SDK MonitorFromWindow
		external
			"C inline use <windows.h>"
		alias
			"MonitorFromWindow((HWND) $a_hwnd, (DWORD) $a_flags)"
		end

	get_monitor_info (a_monitor_handle: POINTER; a_monitor_info: POINTER): BOOLEAN
			-- SDK GetMonitorInfo
		external
			"C inline use <windows.h>"
		alias
			"GetMonitorInfo ((HMONITOR) $a_monitor_handle, (LPMONITORINFO) $a_monitor_info)"
		end

feature -- Drawings

	exclude_clip_rect (hdc: POINTER; left, top, right, bottom: INTEGER): INTEGER
			-- SDK ExcludeClipRect
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER) ExcludeClipRect((HDC) $hdc, (int) $left, (int) $top, (int) $right, (int) $bottom);"
		end

feature -- Dialogs

	end_dialog (hwnd, return_value: POINTER): BOOLEAN
			-- SDK EndDialog
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(EndDialog((HWND) $hwnd, (INT_PTR) $return_value));"
		end

feature -- Menus

	set_menu (hwnd, hmenu: POINTER): INTEGER
			-- SDK SetMenu
		external
			"C inline use <windows.h>"
		alias
			"SetMenu ((HWND) $hwnd, (HMENU) $hmenu)"
		end

	track_popup_menu (hmenu: POINTER; flags, x, y, reserved: INTEGER; hwnd, rect: POINTER)
			-- SDK TrackPopupMenu
		external
			"C inline use <windows.h>"
		alias
			"TrackPopupMenu((HMENU) $hmenu, (UINT) $flags, (int) $x, (int) $y, (int) $reserved, (HWND) $hwnd, (RECT *) $rect)"
		end

	get_menu (hwnd: POINTER): POINTER
			-- SDK GetMenu
		external
			"C inline use <windows.h>"
		alias
			"GetMenu ((HWND) $hwnd)"
		end

	get_menu_bar_info (hwnd: POINTER; id_object, id_item: INTEGER; menu_bar_info: POINTER): INTEGER
			-- SDK GetMenuBarInfo
		external
			"C inline use <windows.h>"
		alias
			"GetMenuBarInfo((HWND) $hwnd, (LONG) $id_object, (LONG) $id_item, (PMENUBARINFO) $menu_bar_info)"
		end

	get_menu_item_rect (hwnd, hmenu: POINTER; uitem: INTEGER; rect: POINTER): INTEGER
			-- SDK GetMenuItemRect
		external
			"C inline use <windows.h>"
		alias
			"GetMenuItemRect((HWND) $hwnd, (HMENU) $hmenu, (UINT) $uitem, (RECT *) $rect)"
		end

feature -- Window class

	set_window_long (hwnd: POINTER; offset: INTEGER_32; value: POINTER): POINTER
			-- SDK SetWindowLongPtr
		external
			"C inline use %"wel.h%""
		alias
			"return (EIF_POINTER) SetWindowLongPtr ((HWND) $hwnd, (int) $offset, (LONG_PTR) $value);"
		end

	get_window_long (hwnd: POINTER; offset: INTEGER_32): POINTER
			-- SDK GetWindowLongPtr
		external
			"C inline use %"wel.h%""
		alias
			"return (EIF_POINTER) GetWindowLongPtr ((HWND) $hwnd, (int) $offset);"
		end

feature -- Messages

	post_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK PostMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	post_message_result_boolean (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): BOOLEAN
			-- SDK PostMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	post_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER)
			-- SDK PostMessage (without the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	register_window_message (a_message_name: POINTER): INTEGER
			-- Register a custom window message named `message_name'.
			-- `Result' is id of new message.
		external
			"C inline use <windows.h>"
		alias
			"RegisterWindowMessage ((LPCTSTR) $a_message_name)"
		end

	send_message_result (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK SendMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	send_message_result_integer (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): INTEGER
			-- SDK SendMessage (with an integer result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	send_message_result_boolean (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): BOOLEAN
			-- SDK SendMessage (with a boolean result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	send_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER)
			-- SDK SendMessage
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam)"
		end

	send_message_timeout (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER; fuflags, utimeout: INTEGER; lpdwresult: TYPED_POINTER [INTEGER])
			-- SDK SendMessageTimeout
		external
			"C inline use <windows.h>"
		alias
			"SendMessageTimeout ((HWND) $hwnd, (UINT) $msg, (WPARAM) $wparam, (LPARAM) $lparam, (UINT) $fuflags, (UINT) $utimeout, (PDWORD_PTR) $lpdwresult)"
		end

feature -- File Drop Handling

	drag_query_file (hdrop: POINTER; ifile: INTEGER; buffer_pointer: POINTER; buffer_size: INTEGER): INTEGER
			-- SDK DragQueryFile
		external
			"C inline use %"wel.h%""
		alias
			"DragQueryFile ((HDROP) $hdrop, (UINT) $ifile, (LPTSTR) $buffer_pointer, (UINT) $buffer_size)"
		end

feature -- Processes

	duplicate_handle (hsourceprocess, hsource, htargetprocess: POINTER; htarget: TYPED_POINTER [POINTER]; access: INTEGER; inherithandle: BOOLEAN; options: INTEGER): INTEGER
			-- SDK DuplicateHandle
		external
			"C inline use <windows.h>"
		alias
			"[
				return (EIF_INTEGER) DuplicateHandle (
					(HANDLE) $hsourceprocess,
					(HANDLE) $hsource,
					(HANDLE) $htargetprocess,
					(LPHANDLE) $htarget,
					(DWORD) $access,
					(BOOL) $inherithandle,
					(DWORD) $options);
			]"
		end

	close_handle (a_handle: POINTER): INTEGER
			-- SDK CloseHandle
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER) CloseHandle ((HANDLE) $a_handle);"
		end

	get_current_process: POINTER
			-- SDK GetCurrentProcess
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetCurrentProcess();"
		end

	wait_for_input_idle (hprocess: POINTER; ms: INTEGER): INTEGER
			-- SDK WaitForInputIdle
		external
			"C blocking inline use <windows.h>"
		alias
			"return (EIF_INTEGER) WaitForInputIdle ((HANDLE) $hprocess, (DWORD) $ms);"
		end

	msg_wait_for_multiple_objects (n: INTEGER; phandles: POINTER; waitall: BOOLEAN; ms, mask: INTEGER): INTEGER
			-- SDK MsgWaitForMultipleObjects
		external
			"C blocking inline use <windows.h>"
		alias
			"[
				return (EIF_INTEGER) MsgWaitForMultipleObjects(
					(DWORD) $n,
					(LPHANDLE) $phandles,
					(BOOL) $waitall,
					(DWORD) $ms,
					(DWORD) $mask);
			]"
		end

	msg_wait_for_multiple_objects_ex (n: INTEGER; phandles: POINTER; ms, wakemask, flags: INTEGER): INTEGER
			-- SDK MsgWaitForMultipleObjectsEx
		external
			"C blocking inline use <windows.h>"
		alias
			"[
				return (EIF_INTEGER) MsgWaitForMultipleObjectsEx(
					(DWORD) $n,
					(LPHANDLE) $phandles,
					(DWORD) $ms,
					(DWORD) $wakemask,
					(DWORD) $flags);
			]"
		end

feature -- Threads

	resume_thread (a_thread: POINTER): INTEGER
			-- SDK ResumeThread
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER_32) ResumeThread((HANDLE) $a_thread);"
		end

feature -- Scrolling

	set_control_scroll_info (hwnd: POINTER; info: POINTER; redraw: BOOLEAN): INTEGER
			-- Sets the parameters of a control scroll bar, including the minimum and maximum
			-- scrolling positions, the page size, and the position of the scroll box (thumb).
			-- The function also redraws the scroll bar, if requested.
			--
			--| Note: if the call does not seem to work as pointed out by the following discussion thread:
			--| http://groups.google.com/group/microsoft.public.win32.programmer.ui/browse_frm/thread/91fe1923a5aef60
			--| try to send the SBM_SETSCROLLINFO as shown in the commented alias clause.
		external
			"C inline use  <windows.h>"
		alias
			"return SetScrollInfo((HWND) $hwnd, SB_CTL, (LPCSCROLLINFO) $info, (BOOL) $redraw);"
--			"return (EIF_INTEGER) SendMessage ((HWND) $hwnd, SBM_SETSCROLLINFO, (WPARAM) $redraw, (LPARAM) $info);"
		end

	get_control_scroll_info (hwnd: POINTER; info: POINTER): INTEGER
			-- Retrieves the parameters of a control scroll bar, including the minimum and maximum
			-- scrolling positions, the page size, and the position of the scroll box (thumb).
			--
			--| Note: like `set_control_scroll_info' if it does not work you may try to
			--| send the SBM_GETSCROLLINFO message as shown in the commented alias clause.
		external
			"C inline use <windows.h>"
		alias
			"return GetScrollInfo((HWND) $hwnd, SB_CTL, (LPSCROLLINFO) $info);"
--			"return (EIF_INTEGER) SendMessage ((HWND) $hwnd, SBM_GETSCROLLINFO, (WPARAM) 0, (LPARAM) $info);"
		end

	get_scroll_info (a_hwnd: POINTER; a_bar: INTEGER; a_info: POINTER): INTEGER
			-- Retrieves the parameters of a scroll bar, including the minimum and maximum
			-- scrolling positions, the page size, and the position of the scroll box (thumb).
			--
			-- `a_bar' can be {WEL_SB_CONSTANTS}.Sb_ctl, Sb_horz, Sb_vert
		external
			"C inline use <windows.h>"
		alias
			"return GetScrollInfo((HWND) $a_hwnd, (int) $a_bar, (LPSCROLLINFO) $a_info);"
		end

feature -- Shell

	shell_notify_icon (a_message: INTEGER; a_notify_icon_data_ptr: POINTER): INTEGER
			-- Sends a message to the taskbar's status area.
		external
			"C inline use <shellapi.h>"
		alias
			"Shell_NotifyIcon((DWORD) $a_message, (PNOTIFYICONDATA) $a_notify_icon_data_ptr)"
		end

feature -- Character codes

	vk_key_scan (a_char: CHARACTER_32): INTEGER_32
			-- Given a character `a_char' gives us the key that triggers its generation.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER_32) VkKeyScan ((TCHAR) $a_char);"
		end

feature -- Error

	get_last_error: INTEGER
			-- SDK GetLastError

		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER_32)GetLastError()"
		end

feature -- API

	load_module (a_name: POINTER): POINTER
			-- Load module with `a_name'.
			-- `a_name' is LPCTSTR, we should use WEL_STRING here.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) LoadLibrary ((LPCTSTR) $a_name);"
		end

	free_module (a_module: POINTER): BOOLEAN
			-- Free module which instance is `a_module'
		external
			"C inline use <windows.h>"
		alias
			"return (BOOL) FreeLibrary ((HMODULE) $a_module);"
		end

	load_api (a_module: POINTER; a_name: POINTER): POINTER
			-- Load api which name is `a_name' in `a_module'
		external
			"C inline use <windows.h>"
		alias
			"return GetProcAddress ((HMODULE) $a_module,(LPCSTR) $a_name);"
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

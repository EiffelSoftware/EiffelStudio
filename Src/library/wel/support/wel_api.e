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
		ensure
			is_class: class
		end

	child_window_from_point (hwnd_parent: POINTER; point: POINTER): POINTER
			-- SDK ChildWindowFromPoint
		external
			"C inline use <windows.h>"
		alias
			"ChildWindowFromPoint ((HWND) $hwnd_parent, * ((POINT*) $point))"
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	set_window_text (hwnd, str: POINTER)
			-- SDK SetWindowText
		external
			"C macro signature (HWND, LPCTSTR) use <windows.h>"
		alias
			"SetWindowText"
		ensure
			is_class: class
		end

	get_window_text (hwnd, str: POINTER; len: INTEGER): INTEGER
			-- SDK GetWindowText
		external
			"C macro signature (HWND, LPTSTR, int): EIF_INTEGER use <windows.h>"
		alias
			"GetWindowText"
		ensure
			is_class: class
		end

	set_parent (hwnd_child, hwnd_parent: POINTER): POINTER
			-- Change the parent of the given child and return handle to
			-- previous parent, or NULL otherwise.
		external
			"C macro signature (HWND, HWND): EIF_POINTER use <windows.h>"
		alias
			"SetParent"
		ensure
			is_class: class
		end

	move_window (hwnd: POINTER; a_x, a_y, a_w, a_h: INTEGER; repaint: BOOLEAN): BOOLEAN
			-- SDK MoveWindow
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(MoveWindow((HWND) $hwnd, (int) $a_x, (int) $a_y, (int) $a_w, (int) $a_h, (BOOL) $repaint));"
		ensure
			is_class: class
		end

	set_window_pos (hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h, flags: INTEGER): BOOLEAN
			-- SDK SetWindowPos
		external
			"C macro signature (HWND, HWND, int, int, int, int, UINT): EIF_BOOLEAN use <windows.h>"
		alias
			"SetWindowPos"
		ensure
			is_class: class
		end

	begin_defer_window_pos (n: INTEGER): POINTER
			-- SDK BeginDeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return BeginDeferWindowPos((int) $n);"
		ensure
			is_class: class
		end

	defer_window_pos (hdwp, hwnd, hwnd_after: POINTER; a_x, a_y, a_w, a_h, flags: INTEGER): POINTER
			-- SDK DeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return DeferWindowPos((HDWP) $hdwp, (HWND) $hwnd, (HWND) $hwnd_after, (int) $a_x, (int) $a_y, (int) $a_w, (int) $a_h, (UINT) $flags);"
		ensure
			is_class: class
		end

	end_defer_window_pos (hdwp: POINTER): BOOLEAN
			-- SDK EndDeferWindowPos
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(EndDeferWindowPos((HDWP) $hdwp));"
		ensure
			is_class: class
		end

	get_focus: POINTER
			-- SDK GetFocus
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetFocus();"
		ensure
			is_class: class
		end

	get_parent (a_hwnd: POINTER): POINTER
			-- SDK GetParent
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetParent((HWND) $a_hwnd);"
		ensure
			is_class: class
		end

	get_window (a_hwnd: POINTER; a_cmd: INTEGER): POINTER
			-- SDK GetWindow
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetWindow ((HWND) $a_hwnd, (UINT) $a_cmd);"
		ensure
			is_class: class
		end

	destroy_window (hwnd: POINTER): BOOLEAN
			-- SDK DestroyWindow
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(DestroyWindow((HWND) $hwnd));"
		ensure
			is_class: class
		end

	find_window (a_class_name, a_window_name: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"return FindWindow((LPCTSTR) $a_class_name, (LPCTSTR) $a_window_name);"
		ensure
			is_class: class
		end

	find_window_ex (a_parent, a_child_after, a_class_name, a_window_name: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"return FindWindowEx((HWND) $a_parent, (HWND) $a_child_after, (LPCTSTR) $a_class_name, (LPCTSTR) $a_window_name);"
		ensure
			is_class: class
		end

	adjust_window_rect_ex (a_rect: POINTER; a_style, a_ex_style: INTEGER; a_is_menu: BOOLEAN): BOOLEAN
			-- Wrapper for AdjustWindowRectEx.
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(AdjustWindowRectEx((LPRECT) $a_rect, (DWORD) $a_style, (DWORD) $a_ex_style, (BOOL) $a_is_menu));"
		ensure
			is_class: class
		end

feature -- Data Operations

	loword (value: POINTER): INTEGER
			-- SDK LOWORD
		external
			"C macro use <windows.h>"
		alias
			"LOWORD"
		ensure
			is_class: class
		end

	hiword (value: POINTER): INTEGER
			-- SDK HIWORD
		external
			"C macro use <windows.h>"
		alias
			"HIWORD"
		ensure
			is_class: class
		end

	makelong (low, high: INTEGER): POINTER
			-- SDK MAKELONG
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) (rt_uint_ptr) MAKELONG($low, $high);"
		ensure
			is_class: class
		end

	lparam (i: INTEGER): POINTER
			-- Convert integer value `i' in a valid `LPARAM' value.
		external
			"C macro use <windows.h>"
		alias
			"(LPARAM)"
		ensure
			is_class: class
		end

	wparam (i: INTEGER): POINTER
			-- Convert integer value `i' in a valid `WPARAM' value.
		external
			"C macro use <windows.h>"
		alias
			"(WPARAM)"
		ensure
			is_class: class
		end

	lresult (i: INTEGER): POINTER
			-- Convert integer value `i' in a valid LRESULT value.
		external
			"C macro use <windows.h>"
		alias
			"(LRESULT)"
		ensure
			is_class: class
		end

feature -- Multi-monitor

	monitor_from_rect (a_rect: POINTER; a_flags: INTEGER_32): POINTER
			-- SDK MonitorFromRect
		external
			"C inline use <windows.h>"
		alias
			"MonitorFromRect((LPCRECT) $a_rect, (DWORD) $a_flags)"
		ensure
			is_class: class
		end

	monitor_from_window (a_hwnd: POINTER; a_flags: INTEGER_32): POINTER
			-- SDK MonitorFromWindow
		external
			"C inline use <windows.h>"
		alias
			"MonitorFromWindow((HWND) $a_hwnd, (DWORD) $a_flags)"
		ensure
			is_class: class
		end

	get_monitor_info (a_monitor_handle: POINTER; a_monitor_info: POINTER): BOOLEAN
			-- SDK GetMonitorInfo
		external
			"C inline use <windows.h>"
		alias
			"GetMonitorInfo ((HMONITOR) $a_monitor_handle, (LPMONITORINFO) $a_monitor_info)"
		ensure
			is_class: class
		end

feature -- Caret Handling

	get_caret_pos (a_point: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"GetCaretPos ((LPPOINT) $a_point)"
		ensure
			is_class: class
		end

feature -- Drawings

	exclude_clip_rect (hdc: POINTER; left, top, right, bottom: INTEGER): INTEGER
			-- SDK ExcludeClipRect
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER) ExcludeClipRect((HDC) $hdc, (int) $left, (int) $top, (int) $right, (int) $bottom);"
		ensure
			is_class: class
		end

feature -- Dialogs

	end_dialog (hwnd, return_value: POINTER): BOOLEAN
			-- SDK EndDialog
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST(EndDialog((HWND) $hwnd, (INT_PTR) $return_value));"
		ensure
			is_class: class
		end

feature -- Menus

	set_menu (hwnd, hmenu: POINTER): INTEGER
			-- SDK SetMenu
		external
			"C inline use <windows.h>"
		alias
			"SetMenu ((HWND) $hwnd, (HMENU) $hmenu)"
		ensure
			is_class: class
		end

	track_popup_menu (hmenu: POINTER; flags, x, y, reserved: INTEGER; hwnd, rect: POINTER): INTEGER
			-- SDK TrackPopupMenu
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER) TrackPopupMenu((HMENU) $hmenu, (UINT) $flags, (int) $x, (int) $y, (int) $reserved, (HWND) $hwnd, (RECT *) $rect);"
		ensure
			is_class: class
		end

	get_menu (hwnd: POINTER): POINTER
			-- SDK GetMenu
		external
			"C inline use <windows.h>"
		alias
			"GetMenu ((HWND) $hwnd)"
		ensure
			is_class: class
		end

	get_menu_bar_info (hwnd: POINTER; id_object, id_item: INTEGER; menu_bar_info: POINTER): INTEGER
			-- SDK GetMenuBarInfo
		external
			"C inline use <windows.h>"
		alias
			"GetMenuBarInfo((HWND) $hwnd, (LONG) $id_object, (LONG) $id_item, (PMENUBARINFO) $menu_bar_info)"
		ensure
			is_class: class
		end

	get_menu_item_rect (hwnd, hmenu: POINTER; uitem: INTEGER; rect: POINTER): INTEGER
			-- SDK GetMenuItemRect
		external
			"C inline use <windows.h>"
		alias
			"GetMenuItemRect((HWND) $hwnd, (HMENU) $hmenu, (UINT) $uitem, (RECT *) $rect)"
		ensure
			is_class: class
		end

feature -- Window class

	set_window_long (hwnd: POINTER; offset: INTEGER_32; value: POINTER): POINTER
			-- SDK SetWindowLongPtr
		external
			"C macro signature (HWND, int, LONG_PTR): EIF_POINTER use %"wel.h%""
		alias
			"SetWindowLongPtr"
		ensure
			is_class: class
		end

	get_window_long (hwnd: POINTER; offset: INTEGER_32): POINTER
			-- SDK GetWindowLongPtr
		external
			"C macro signature (HWND, int): EIF_POINTER use %"wel.h%""
		alias
			"GetWindowLongPtr"
		ensure
			is_class: class
		end

feature -- Messages

	post_message_result (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER): BOOLEAN
			-- SDK PostMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	post_message (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER)
			-- SDK PostMessage (without the result)
		external
			"C inline use <windows.h>"
		alias
			"PostMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	post_thread_message (idthread: INTEGER; msg: INTEGER; a_wparam, a_lparam: POINTER)
			-- SDK PostThreadMessage (without the result)
		external
			"C inline use <windows.h>"
		alias
			"PostThreadMessage ((DWORD) $idthread, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	register_window_message (a_message_name: POINTER): INTEGER
			-- Register a custom window message named `message_name'.
			-- `Result' is id of new message.
		external
			"C inline use <windows.h>"
		alias
			"RegisterWindowMessage ((LPCTSTR) $a_message_name)"
		ensure
			is_class: class
		end

	send_message_result (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER): POINTER
			-- SDK SendMessage (with the result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	send_message_result_integer (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER): INTEGER
			-- SDK SendMessage (with an integer result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	send_message_result_boolean (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER): BOOLEAN
			-- SDK SendMessage (with a boolean result)
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	send_message (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER)
			-- SDK SendMessage
		external
			"C inline use <windows.h>"
		alias
			"SendMessage ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam)"
		ensure
			is_class: class
		end

	send_message_timeout (hwnd: POINTER; msg: INTEGER; a_wparam, a_lparam: POINTER; fuflags, utimeout: INTEGER; lpdwresult: TYPED_POINTER [INTEGER])
			-- SDK SendMessageTimeout
		external
			"C inline use <windows.h>"
		alias
			"SendMessageTimeout ((HWND) $hwnd, (UINT) $msg, (WPARAM) $a_wparam, (LPARAM) $a_lparam, (UINT) $fuflags, (UINT) $utimeout, (PDWORD_PTR) $lpdwresult)"
		ensure
			is_class: class
		end

feature -- File Drop Handling

	drag_query_file (hdrop: POINTER; ifile: INTEGER; buffer_pointer: POINTER; buffer_size: INTEGER): INTEGER
			-- SDK DragQueryFile
		external
			"C inline use %"wel.h%""
		alias
			"DragQueryFile ((HDROP) $hdrop, (UINT) $ifile, (LPTSTR) $buffer_pointer, (UINT) $buffer_size)"
		ensure
			is_class: class
		end

feature -- File input/output

	cwin_create_file (name: POINTER; desired_access: NATURAL_32; shared_mode: NATURAL_32; security_attributes: POINTER; creation_disposition: NATURAL_32; flags_and_attributes: NATURAL_32; template_handle: POINTER): POINTER
			-- SDK CreateFile.
		external
			"C [macro <winbase.h>] (LPCTSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE): HANDLE"
		alias
			"CreateFile"
		ensure
			is_class: class
		end

	cwin_read_file (file_handle: POINTER; buffer: POINTER; number_of_bytes_to_read: NATURAL_32; number_of_bytes_read: TYPED_POINTER [NATURAL_32]; overlapped: POINTER): BOOLEAN
			-- SDK ReadFile.
		external
			"C blocking macro signature (HANDLE, LPVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL use <winbase.h>"
		alias
			"ReadFile"
		ensure
			is_class: class
		end

	cwin_read_file_with_error (file_handle: POINTER; buffer: POINTER; number_of_bytes_to_read: NATURAL_32; number_of_bytes_read: TYPED_POINTER [NATURAL_32]; overlapped: POINTER; last_error: TYPED_POINTER [NATURAL_32]): BOOLEAN
			-- SDK ReadFile.
		external
			"C blocking inline use <winbase.h>"
		alias
			"[
				BOOL b = ReadFile ($file_handle, $buffer, $number_of_bytes_to_read, $number_of_bytes_read, $overlapped);
				* $last_error = GetLastError ();
				return EIF_TEST (b);
			]"
		ensure
			is_class: class
		end

	cwin_write_file (file_handle: POINTER; buffer: POINTER; number_of_bytes_to_write: NATURAL_32; number_of_bytes_written: TYPED_POINTER [NATURAL_32]; overlapped: POINTER): BOOLEAN
			-- SDK WriteFile.
		external
			"C blocking macro signature (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED): BOOL use <winbase.h>"
		alias
			"WriteFile"
		ensure
			is_class: class
		end

feature -- Processes

	create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
					a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
					a_startup_info, a_process_info: POINTER): BOOLEAN
			-- SDK CreateProcess
		external
			"C macro signature (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN use <winbase.h>"
		alias
			"CreateProcess"
		ensure
			is_class: class
		end

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
		ensure
			is_class: class
		end

	close_handle (a_handle: POINTER): INTEGER
			-- SDK CloseHandle
			-- If the function fails, the return value is zero.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER) CloseHandle ((HANDLE) $a_handle);"
		ensure
			is_class: class
		end

	get_current_process: POINTER
			-- SDK GetCurrentProcess
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) GetCurrentProcess();"
		ensure
			is_class: class
		end

	wait_for_input_idle (hprocess: POINTER; ms: INTEGER): INTEGER
			-- SDK WaitForInputIdle
		external
			"C blocking inline use <windows.h>"
		alias
			"return (EIF_INTEGER) WaitForInputIdle ((HANDLE) $hprocess, (DWORD) $ms);"
		ensure
			is_class: class
		end

	wait_for_single_object (handle: POINTER; type: INTEGER): INTEGER
		external
			"C blocking macro signature (HANDLE, DWORD): EIF_INTEGER use <windows.h>"
		alias
			"WaitForSingleObject"
		ensure
			is_class: class
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
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	wait_object_0: INTEGER
			-- SDK WAIT_OBJECT_0 constant.
		external
			"C macro use <windows.h>"
		alias
			"WAIT_OBJECT_0"
		ensure
			is_class: class
		end

	wait_timeout: INTEGER
			-- SDK WAIT_TIMEOUT constant.
		external
			"C macro use <windows.h>"
		alias
			"WAIT_TIMEOUT"
		ensure
			is_class: class
		end

	wait_failed: INTEGER
			-- SDK WAIT_FAILED constant.
		external
			"C macro use <windows.h>"
		alias
			"WAIT_FAILED"
		ensure
			is_class: class
		end

	infinite: INTEGER
			-- SDK INFINITE constant.
		external
			"C macro use <winbase.h>"
		alias
			"INFINITE"
		ensure
			is_class: class
		end

	get_exit_code_process (handle: POINTER; ptr: POINTER): BOOLEAN
			-- SDK GetExitCodeProcess
		external
			"C inline use <winbase.h>"
		alias
			"return EIF_TEST(GetExitCodeProcess ((HANDLE) $handle, (LPDWORD) $ptr));"
		ensure
			is_class: class
		end

	terminate_process (handle: POINTER; exit_code: INTEGER): BOOLEAN
			-- SDK TerminateProcess
		external
			"C inline use <winbase.h>"
		alias
			"return EIF_TEST(TerminateProcess((HANDLE) $handle, (DWORD) $exit_code));"
		ensure
			is_class: class
		end

	still_active: INTEGER
			-- SDK STILL_ACTIVE constant
		external
			"C macro use <windows.h>"
		alias
			"STILL_ACTIVE"
		ensure
			is_class: class
		end

feature -- Threads

	resume_thread (a_thread: POINTER): INTEGER
			-- SDK ResumeThread
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER_32) ResumeThread((HANDLE) $a_thread);"
		ensure
			is_class: class
		end

feature -- Code pages

	console_input_code_page: NATURAL_32
			-- Input code page of the console.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_NATURAL_32) GetConsoleCP ();"
		ensure
			is_class: class
		end

	console_output_code_page: NATURAL_32
			-- Output code page of the console.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_NATURAL_32) GetConsoleOutputCP ();"
		ensure
			is_class: class
		end

	set_console_input_code_page (cp: NATURAL_32): BOOLEAN
			-- Set input code page of the console to `cp'.
			-- Return True on success and False on error.
			-- Use `get_last_error' to get extended error information.
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST (SetConsoleCP ((UINT) $cp));"
		ensure
			is_class: class
		end

	set_console_output_code_page (cp: NATURAL_32): BOOLEAN
			-- Set output code page of the console to `cp'.
			-- Return True on success and False on error.
			-- Use `get_last_error' to get extended error information.
		external
			"C inline use <windows.h>"
		alias
			"return EIF_TEST (SetConsoleOutputCP ((UINT) $cp));"
		ensure
			is_class: class
		end


	oem_code_page: NATURAL_32
			-- The current OEM code page identifier for the operating system.
			-- The OEM code page is used for conversion from MS-DOS-based, text-mode applications.
		external
			"C inline use <Winnls.h>"
		alias
			"return (EIF_NATURAL_32) GetOEMCP ();"
		ensure
			is_class: class
		end

	ansi_code_page: NATURAL_32
			-- The current Windows ANSI code page (ACP) identifier for the operating system.
		external
			"C inline use <Winnls.h>"
		alias
			"return (EIF_NATURAL_32) GetACP ();"
		ensure
			is_class: class
		end

feature -- Metrics

	get_system_metrics (value: INTEGER): INTEGER
			-- SDK GetSystemMetrics
		external
			"C inline use <windows.h>"
		alias
			"return GetSystemMetrics ((int) $value);"
		ensure
			is_class: class
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
		ensure
			is_class: class
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
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

feature -- Shell

	shell_notify_icon (a_message: INTEGER; a_notify_icon_data_ptr: POINTER): INTEGER
			-- Sends a message to the taskbar's status area.
		external
			"C inline use <shellapi.h>"
		alias
			"Shell_NotifyIcon((DWORD) $a_message, (PNOTIFYICONDATA) $a_notify_icon_data_ptr)"
		ensure
			is_class: class
		end

feature -- Printing

	get_default_printer (a_name: POINTER; a_name_length: TYPED_POINTER [INTEGER]; a_error_code: TYPED_POINTER [INTEGER]): BOOLEAN
			-- The GetDefaultPrinter function retrieves the printer name
			-- of the default printer for the current user on the local computer.
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"[
				EIF_BOOLEAN result = EIF_TEST(GetDefaultPrinter((LPTSTR) $a_name, (LPDWORD) $a_name_length));
				if (!result && $a_error_code) {
					*(EIF_INTEGER *) $a_error_code = (EIF_INTEGER) GetLastError();
				}
				return result;
			]"
		ensure
			is_class: class
		end

	open_printer (a_name: POINTER; a_printer_handle: TYPED_POINTER [POINTER]; a_defaults: POINTER): BOOLEAN
			-- The OpenPrinter function retrieves a handle to the specified printer or print
			-- server or other types of handles in the print subsystem.
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return EIF_TEST(OpenPrinter((LPTSTR) $a_name, (LPHANDLE) $a_printer_handle, (LPPRINTER_DEFAULTS) $a_defaults));"
		ensure
			is_class: class
		end

	get_printer (a_printer: POINTER; a_level: INTEGER; a_printer_info: POINTER; a_buf_size: INTEGER;
				a_printer_info_length: TYPED_POINTER [INTEGER];
				a_error_code: TYPED_POINTER [INTEGER]): BOOLEAN
			-- The GetPrinter function retrieves information about a specified printer.
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"[
				EIF_BOOLEAN result = EIF_TEST(GetPrinter((HANDLE) $a_printer, (DWORD) $a_level,
					(LPBYTE) $a_printer_info, (DWORD) $a_buf_size, (LPDWORD) $a_printer_info_length));
				if (!result && $a_error_code) {
					*(EIF_INTEGER *) $a_error_code = (EIF_INTEGER) GetLastError();
				}
				return result;
			]"
		ensure
			is_class: class
		end

	close_printer (a_printer: POINTER): BOOLEAN
			-- The ClosePrinter function closes the specified printer object.
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return EIF_TEST(ClosePrinter((HANDLE) $a_printer));"
		ensure
			is_class: class
		end

feature -- Character codes

	vk_key_scan (a_char: CHARACTER_32): INTEGER_32
			-- Given a character `a_char' gives us the key that triggers its generation.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_INTEGER_32) VkKeyScan ((TCHAR) $a_char);"
		ensure
			is_class: class
		end

feature -- Error

	get_last_error: INTEGER
			-- SDK GetLastError
			-- WARNING: it mays return wrong value in Multithreaded or SCOOP mode
			-- it is recommended to get the last error within the same C external.
		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER_32)GetLastError()"
		ensure
			is_class: class
		end

feature -- API

	load_module (a_name: POINTER): POINTER
			-- Load module with `a_name'.
			-- `a_name' is LPCTSTR, we should use WEL_STRING here.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) LoadLibrary ((LPCTSTR) $a_name);"
		ensure
			is_class: class
		end

	free_module (a_module: POINTER): BOOLEAN
			-- Free module which instance is `a_module'
		external
			"C inline use <windows.h>"
		alias
			"return (BOOL) FreeLibrary ((HMODULE) $a_module);"
		ensure
			is_class: class
		end

	load_api (a_module: POINTER; a_name: POINTER): POINTER
			-- Load api which name is `a_name' in `a_module'
		external
			"C inline use <windows.h>"
		alias
			"return GetProcAddress ((HMODULE) $a_module,(LPCSTR) $a_name);"
		ensure
			is_class: class
		end


note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

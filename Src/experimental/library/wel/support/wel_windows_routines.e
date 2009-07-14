note
	description: "Basic Windows routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOWS_ROUTINES

inherit
	ANY

	WEL_IDENTIFIED
		export
			{NONE} all
		end

	WEL_MB_CONSTANTS
		export
			{NONE} all
			{ANY} default_pointer
		end

	WEL_GWL_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

feature -- Basic operations

	output_debug_string (s: STRING_GENERAL)
			-- Send a string `s' to the system debugger.
		require
			s_not_void: s /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (s)
			cwin_output_debug_string (a_wel_string.item)
		end

	message_beep_asterisk
			-- Play the system asterisk waveform sound.
		do
			cwin_message_beep (Mb_iconasterisk)
		end

	message_beep_exclamation
			-- Play the system exclamation waveform sound.
		do
			cwin_message_beep (Mb_iconexclamation)
		end

	message_beep_hand
			-- Play the system hand waveform sound.
		do
			cwin_message_beep (Mb_iconhand)
		end

	message_beep_question
			-- Play the system question waveform sound.
		do
			cwin_message_beep (Mb_iconquestion)
		end

	message_beep_ok
			-- Play the system ok waveform sound.
		do
			cwin_message_beep (Mb_ok)
		end

	show_cursor
			-- Show the cursor.
		do
			cwin_show_cursor (True)
		end

	hide_cursor
			-- Hide the cursor.
		do
			cwin_show_cursor (False)
		end

	set_cursor_position_absolute (x, y: INTEGER)
			-- Set the cursor position to `x', `y'.
		do
			cwin_set_cursor_position (x, y)
		end

	resource_string_id (an_id: INTEGER): STRING_32
			-- String identified by `an_id' in the resource file.
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create a_wel_string.make_empty (1024)
			nb := cwin_load_string (
				wr_main_args.resource_instance.item,
				an_id, a_wel_string.item, 1024)
			Result := a_wel_string.substring (1, nb)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_window (hwnd: POINTER): BOOLEAN
			-- Does `hwnd' point to a valid Window?
		external
			"C [macro <windows.h>] (HWND): EIF_BOOLEAN"
		alias
			"IsWindow"
		end

	window_of_item (hwnd: POINTER): detachable WEL_WINDOW
			-- Retrieve Eiffel object associated with `hwnd' pointer.
		require
			hwnd_not_null: hwnd /= default_pointer
			is_window_pointer: is_window (hwnd)
		local
			l_data, null, window_process_id, current_process_id, l_pointer: POINTER
			retried: BOOLEAN
			l_id: INTEGER
		do
			if not retried then
				l_data := cwin_get_window_long (hwnd, gwlp_userdata)
					-- All WEL windows have associated data, so if there is none, we know
					-- it was not one of our windows.
				if l_data /= null then
						-- Retreive the process id associated with `hwnd' into `window_process_id'.
					l_pointer := cwin_get_window_thread_process_id (hwnd, $window_process_id)
						-- Retrieve the process id of the current process.
					current_process_id := cwin_get_current_process_id

						-- If the process of the window is that of the current id and that it is not
						-- the DOS prompt associated with the current process then
						-- we know it must be one of our windows.
					if window_process_id = current_process_id and l_data /= cwin_console_window_data then
							-- We truncate the value, but this is ok because we only put an INTEGER.
						l_id := l_data.to_integer_32
						check l_id_positive: l_id > 0 end
						Result := eif_id_object (l_id)
						if Result /= Void and then Result.item /= hwnd then
							Result := Void
								-- Window returned has recently been destroyed or had its implementation
								-- swapped so we return Void
						end
					end
				end
			else
					-- We received an exception because looks like `l_data'
					-- was not a memory area we allocated (since we checked above
					-- the window did belong to us, it means it is not a WEL window,
					-- most likely the DOS console).
					-- In this case, we should return Void.
				Result := Void
			end
		ensure
			is_wel_window: Result /= Void implies
				(create {INTERNAL}).type_conforms_to (
					(create {INTERNAL}).dynamic_type (Result),
					(create {INTERNAL}).dynamic_type_from_string ("WEL_WINDOW"))
			is_proper_wel_window: Result /= Void implies Result.item = hwnd
		rescue
			retried := True
			retry
		end

	key_state (virtual_key: INTEGER): BOOLEAN
		obsolete "Use key_down or key_locked instead"
		do
		end

	key_down (virtual_key: INTEGER): BOOLEAN
			--Is 'virtual' key pressed
		do
			Result := cwel_key_down (virtual_key)
		end

	key_locked (virtual_key: INTEGER): BOOLEAN
			--Is 'virtual' key locked
		do
			Result := cwel_key_locked (virtual_key)
		end

	key_to_string (key_data: INTEGER): STRING_32
			-- Give the string associated with the key given by
			-- `virtual_key'.
		local
			buffer: WEL_STRING
			the_result: BOOLEAN
		do
			create buffer.make_empty (11)
			the_result := cwin_get_key_name_text (key_data, buffer.item, buffer.character_capacity)
			check
				successfull_call: the_result
			end
			Result := buffer.string
		end

	tick_count: INTEGER
			-- Number of milliseconds that have
			-- elapsed since Windows was started.
		do
			Result := cwin_get_tick_count
		ensure
			positive_result: Result >= 0
		end

	system_directory: STRING_32
			-- Path of the Windows system directory
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			nb := cwin_get_system_directory (default_pointer, 0)
			create a_wel_string.make_empty (nb)
			nb := cwin_get_system_directory (a_wel_string.item, nb)
			Result := a_wel_string.substring (1, nb)
		ensure
			result_not_void: Result /= Void
		end

	windows_directory: STRING_32
			-- Path of the Windows directory
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			nb := cwin_get_windows_directory (default_pointer, 0)
			create a_wel_string.make_empty (nb)
			nb := cwin_get_windows_directory (a_wel_string.item, nb)
			Result := a_wel_string.substring (1, nb)
		ensure
			result_not_void: Result /= Void
		end

	foreground_window: detachable WEL_WINDOW
			-- Foreground window (window with focus)
		local
			p, null: POINTER
		do
			p := cwin_get_foreground_window
			if p /= null then
				Result := window_of_item (p)
			end
		end

	is_terminal_service: BOOLEAN
			-- If window in terminal service (Remote Desktop)?
		require
			after_2000: (create {WEL_WINDOWS_VERSION}).is_windows_2000_compatible
		do
			cwin_is_terminal_service ($Result)
		end

feature {NONE} -- Implementation

	wr_main_args: WEL_MAIN_ARGUMENTS
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_message_beep (sound_type: INTEGER)
			-- SDK MessageBeep
		external
			"C [macro %"wel.h%"] (UINT)"
		alias
			"MessageBeep"
		end

	cwin_get_dlg_item (hwnd: POINTER; an_id: INTEGER): POINTER
			-- SDK GetDlgItem
		external
			"C [macro <wel.h>] (HWND, int): EIF_POINTER"
		alias
			"GetDlgItem"
		end

	cwin_get_tick_count: INTEGER
			-- SDK GetTickCount
		external
			"C [macro %"wel.h%"]"
		alias
			"GetTickCount ()"
		end

	cwin_show_cursor (show_flag: BOOLEAN)
			-- SDK ShowCursor
		external
			"C [macro %"wel.h%"] (BOOL)"
		alias
			"ShowCursor"
		end

	cwin_set_cursor_position (x, y: INTEGER)
			-- SDK SetCursorPos
		external
			"C [macro %"wel.h%"] (int, int)"
		alias
			"SetCursorPos"
		end

	cwin_load_string (hinstance: POINTER; id: INTEGER;
			buffer: POINTER; buffer_size: INTEGER): INTEGER
			-- SDK LoadString
		external
			"C [macro %"wel.h%"] (HINSTANCE, UINT, LPTSTR, %
				%int): EIF_INTEGER"
		alias
			"LoadString"
		end

	cwin_get_key_name_text (virtual_key: INTEGER; lptstr: POINTER; nsize: INTEGER): BOOLEAN
			-- Return the string value of the key virtual key.
		external
			"C [macro %"wel.h%"] (LONG, LPTSTR, int): BOOLEAN"
		alias
			"GetKeyNameText"
		end

	cwin_get_key_state (virtual_key: INTEGER): BOOLEAN
			-- SDK GetKeyState
		obsolete "Use cwel_key_down or cwel_key_locked"
		do
		end

	cwel_key_down (virtual_key: INTEGER): BOOLEAN
		external
			"C [macro <wel_windows_routines.h>] (int): EIF_BOOLEAN"
		end

	cwel_key_locked (virtual_key: INTEGER): BOOLEAN
		external
			"C [macro <wel_windows_routines.h>] (int): EIF_BOOLEAN"
		end

	cwin_output_debug_string (s: POINTER)
			-- SDK OutputDebugString
		external
			"C [macro %"wel.h%"] (LPCTSTR)"
		alias
			"OutputDebugString"
		end

	cwin_get_system_directory (buffer: POINTER; size: INTEGER): INTEGER
			-- SDK GetSystemDirectory
		external
			"C [macro %"wel.h%"] (LPTSTR, UINT): EIF_INTEGER"
		alias
			"GetSystemDirectory"
		end

	cwin_get_windows_directory (buffer: POINTER; size: INTEGER): INTEGER
			-- SDK GetWindowsDirectory
		external
			"C [macro %"wel.h%"] (LPTSTR, UINT): EIF_INTEGER"
		alias
			"GetWindowsDirectory"
		end

	cwin_get_foreground_window: POINTER
			-- SDK GetForegroundWindow
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"GetForegroundWindow()"
		end

	cwin_get_window (hwnd: POINTER; relation_flag: INTEGER): POINTER
			-- SDK GetWindow
		external
			"C [macro <wel.h>] (HWND, UINT): EIF_POINTER"
		alias
			"GetWindow"
		end

	cwin_get_window_long (hwnd: POINTER; offset: INTEGER): POINTER
			-- SDK GetWindowLongPtr
		external
			"C [macro %"wel.h%"] (HWND, int): LONG_PTR"
		alias
			"GetWindowLongPtr"
		end

	cwin_set_window_long (hwnd: POINTER; offset: INTEGER; value: POINTER)
			-- SDK SetWindowLongPtr
		external
			"C [macro %"wel.h%"] (HWND, int, LONG_PTR)"
		alias
			"SetWindowLongPtr"
		end

	cwin_redraw_window (hwnd, update_rectangle, update_region: POINTER; flags: INTEGER)
			-- SDK RedrawWindow
		external
			"C [macro %"wel.h%"] (HWND, CONST RECT *, HRGN, UINT)"
		alias
			"RedrawWindow"
		end

	cwin_get_window_thread_process_id (hwnd: POINTER; a_pointer: TYPED_POINTER [POINTER]): POINTER
			--
		external
			"C [macro %"windows.h%"] (HWND, LPDWORD): LONG_PTR"
		alias
			"GetWindowThreadProcessId"
		end

	cwin_get_current_process_id: POINTER
			--
		external
			"C [macro %"windows.h%"] (): DWORD"
		alias
			"GetCurrentProcessId()"
		end

	cwin_console_window_data: POINTER
			--
		local
			l_hwnd: POINTER
		once
			cwin_get_console_hwnd ($l_hwnd)
			if l_hwnd /= default_pointer then
				Result := cwin_get_window_long (l_hwnd, gwlp_userdata)
			end
		end

	cwin_get_console_hwnd (a_result: TYPED_POINTER [POINTER])
			-- Get HWND from console window if any.
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				FARPROC get_console_window_proc = NULL;
				HMODULE kernel32_module = LoadLibrary (L"kernel32.dll");
				if (kernel32_module) {
					get_console_window_proc = GetProcAddress (kernel32_module, "GetConsoleWindow");
					if (get_console_window_proc) {
						*$a_result = (FUNCTION_CAST_TYPE(HWND,WINAPI,(void)) get_console_window_proc) ();
					}
				}
			}
			]"
		end

	cwin_is_terminal_service (a_result: TYPED_POINTER [BOOLEAN])
			-- If window in terminal service (Remote Desktop)?
		external
			"C inline use <Windows.h>"
		alias
			"[
			{
				// This is not defined in VC6
				// define SM_REMOTESESSION  0x1000
				*(EIF_BOOLEAN *) $a_result = GetSystemMetrics(0x1000);
			}
			]"
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




end -- class WEL_WINDOWS_ROUTINES


indexing
	description: "Basic Windows routines."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOWS_ROUTINES

inherit
	WEL_MB_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic operations

	output_debug_string (s: STRING) is
			-- Send a string `s' to the system debugger.
		require
			s_not_void: s /= Void
		local
			a: ANY
		do
			a := s.to_c
			cwin_output_debug_string ($a)
		end

	message_beep_asterisk is
			-- Play the system asterisk waveform sound.
		do
			cwin_message_beep (Mb_iconasterisk)
		end

	message_beep_exclamation is
			-- Play the system exclamation waveform sound.
		do
			cwin_message_beep (Mb_iconexclamation)
		end

	message_beep_hand is
			-- Play the system hand waveform sound.
		do
			cwin_message_beep (Mb_iconhand)
		end

	message_beep_question is
			-- Play the system question waveform sound.
		do
			cwin_message_beep (Mb_iconquestion)
		end

	message_beep_ok is
			-- Play the system ok waveform sound.
		do
			cwin_message_beep (Mb_ok)
		end

	show_cursor is
			-- Show the cursor.
		do
			cwin_show_cursor (True)
		end

	hide_cursor is
			-- Hide the cursor.
		do
			cwin_show_cursor (False)
		end

	set_cursor_position (x, y: INTEGER) is
			-- Set the cursor position to `x', `y'.
		do
			cwin_set_cursor_position (x, y)
		end

	resource_string_id (an_id: INTEGER): STRING is
			-- String identified by `an_id' in the resource file.
		local
			a: ANY
		do
			!! Result.make (1024)
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_load_string (
				wr_main_args.current_instance.item,
				an_id, $a, Result.count))
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_win32: BOOLEAN is
			-- Is the current operating system Windows 95/NT?
		once
			Result := cwel_is_win32
		end

	key_state (virtual_key: INTEGER): BOOLEAN is
			-- Is `virtual_key' down?
		do
			Result := cwin_get_key_state (virtual_key)
		end

	tick_count: INTEGER is
			-- Number of milliseconds that have
			-- elapsed since Windows was started.
		do
			Result := cwin_get_tick_count
		ensure
			positive_result: Result >= 0
		end

	system_directory: STRING is
			-- Path of the Windows system directory
		local
			a: ANY
		do
			!! Result.make (cwin_get_system_directory (default_pointer, 0))
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_system_directory ($a, Result.count))
		ensure
			result_not_void: Result /= Void
		end

	windows_directory: STRING is
			-- Path of the Windows directory
		local
			a: ANY
		do
			!! Result.make (cwin_get_windows_directory (default_pointer, 0))
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_get_windows_directory ($a, Result.count))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	wr_main_args: WEL_MAIN_ARGUMENTS is
		once
			!! Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_message_beep (sound_type: INTEGER) is
			-- SDK MessageBeep
		external
			"C [macro <wel.h>] (UINT)"
		alias
			"MessageBeep"
		end

	cwin_get_tick_count: INTEGER is
			-- SDK GetTickCount
		external
			"C [macro <wel.h>]"
		alias
			"GetTickCount ()"
		end

	cwin_show_cursor (show_flag: BOOLEAN) is
			-- SDK ShowCursor
		external
			"C [macro <wel.h>] (BOOL)"
		alias
			"ShowCursor"
		end

	cwin_set_cursor_position (x, y: INTEGER) is
			-- SDK SetCursorPos
		external
			"C [macro <wel.h>] (int, int)"
		alias
			"SetCursorPos"
		end

	cwin_load_string (hinstance: POINTER; id: INTEGER;
			buffer: POINTER; buffer_size: INTEGER): INTEGER is
			-- SDK LoadString
		external
			"C [macro <wel.h>] (HINSTANCE, UINT, LPSTR, %
				%int): EIF_INTEGER"
		alias
			"LoadString"
		end

	cwin_get_key_state (virtual_key: INTEGER): BOOLEAN is
			-- SDK GetKeyState
		external
			"C [macro <wel.h>] (int): EIF_BOOLEAN"
		alias
			"GetKeyState"
		end

	cwin_output_debug_string (s: POINTER) is
			-- SDK OutputDebugString
		external
			"C [macro <wel.h>] (LPCSTR)"
		alias
			"OutputDebugString"
		end

	cwin_get_system_directory (buffer: POINTER; size: INTEGER): INTEGER is
			-- SDK GetSystemDirectory
		external
			"C [macro <wel.h>] (LPSTR, UINT): EIF_INTEGER"
		alias
			"GetSystemDirectory"
		end

	cwin_get_windows_directory (buffer: POINTER; size: INTEGER): INTEGER is
			-- SDK GetWindowsDirectory
		external
			"C [macro <wel.h>] (LPSTR, UINT): EIF_INTEGER"
		alias
			"GetWindowsDirectory"
		end

	cwel_is_win32: BOOLEAN is
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_WINDOWS_ROUTINES

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

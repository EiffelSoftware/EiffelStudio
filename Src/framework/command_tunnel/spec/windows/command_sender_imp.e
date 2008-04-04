indexing
	description: "Command sender implementation"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_SENDER_IMP

inherit
	COMMAND_SENDER_I

	WEL_WINDOWS_ROUTINES
		export
			{NONE}all
		end

	COMMAND_CONSTANTS

feature -- Operation

	send_command (a_string, a_key: !STRING) is
			-- Send `a_string' as command to receiver processes.
		local
			l_string_to_send: STRING
			l_wel_string: WEL_STRING
			l_copydata: POINTER
		do
			last_key := a_key
			last_command_handled := False
			if not a_string.is_empty then
					-- We add an `ise_command' constants as prefix of the real string sent
					-- to avoid messages send by other unknown processes.
				l_string_to_send := ise_command + a_string
				create l_wel_string.make (l_string_to_send)
				l_copydata := c_new_copydatastruct (l_wel_string.item, l_wel_string.bytes_count)
				last_copydata := l_copydata
				if l_copydata /= Void then
					cwel_enum_windows_procedure (Current, $enum_windows_proc)
				end
				l_copydata.memory_free
				last_copydata := default_pointer
			end
		end

	send_command_process (a_string, a_key: !STRING; a_process_id: INTEGER) is
			-- Send `a_string' as command to receiver process of `a_process_id' with `a_key'.
		local
			l_string_to_send: STRING
			l_wel_string: WEL_STRING
			l_copydata: POINTER
		do
			last_key := a_key
			last_command_handled := False
			last_command_reached := False
			if not a_string.is_empty then
					-- We add an `ise_command' constants as prefix of the real string sent
					-- to avoid messages sent by other unknown processes.
				l_string_to_send := ise_command + a_string
				create l_wel_string.make (l_string_to_send)
				l_copydata := c_new_copydatastruct (l_wel_string.item, l_wel_string.bytes_count)
				last_copydata := l_copydata
				last_process := a_process_id
				if l_copydata /= Void then
					cwel_enum_windows_procedure (Current, $enum_windows_proc_process)
				end
				l_copydata.memory_free
				last_copydata := default_pointer
			end
		end

feature {NONE} -- Access

	last_command_handled: BOOLEAN
			-- <precursor>

	last_command_reached: BOOLEAN
			-- <precursor>

	last_key: STRING

	last_copydata: POINTER

	last_process: INTEGER

feature {NONE} -- Implementation

	enum_windows_proc (hwnd: POINTER): BOOLEAN is
			-- Process `hwnd' when enumerating top windows.
			-- Return True to continue enumerating, otherwise to stop.
		local
			a_wel_string: WEL_STRING
			l_length: INTEGER
			nb: INTEGER
			l_string: STRING
			l_result: BOOLEAN
		do
			Result := True
			l_length := cwin_get_window_text_length (hwnd)
			if l_length > 0 then
				l_length := l_length + 1
				create a_wel_string.make_empty (l_length)
				nb := cwin_get_window_text (hwnd, a_wel_string.item, l_length)
				l_string := a_wel_string.substring (1, nb)
					-- |Fixeme: Information loss when converting to STRING_8.
				l_string := l_string.to_string_8
				if {lt_key: STRING}last_key and then last_copydata /= default_pointer and then lt_key.is_equal (l_string) then
						-- If the receiver return True, it means that the receiver handles the message.
						-- Window enumerating will stop.
					Result := {WEL_API}.send_message_result_boolean (hwnd, {WEL_WM_CONSTANTS}.WM_COPYDATA, default_pointer, last_copydata)
					last_command_handled := last_command_handled or Result
				end
			end
		end

	enum_windows_proc_process (hwnd: POINTER): BOOLEAN is
			-- Process `hwnd' when enumerating top windows.
			-- Return True to continue enumerating, otherwise to stop.
		local
			a_wel_string: WEL_STRING
			l_length: INTEGER
			nb: INTEGER
			l_string: STRING
			l_result: BOOLEAN
			l_hwnd_process_id: POINTER
			l_pointer: POINTER
		do
			Result := True
			l_pointer := cwin_get_window_thread_process_id (hwnd, $l_hwnd_process_id)
			if l_hwnd_process_id.to_integer_32 = last_process then
				l_length := cwin_get_window_text_length (hwnd)
				if l_length > 0 then
					l_length := l_length + 1
					create a_wel_string.make_empty (l_length)
					nb := cwin_get_window_text (hwnd, a_wel_string.item, l_length)
					l_string := a_wel_string.substring (1, nb)
						-- |Fixeme: Information loss when converting to STRING_8.
					l_string := l_string.to_string_8
					if {lt_key: STRING}last_key and then last_copydata /= default_pointer and then lt_key.is_equal (l_string) then
						last_command_handled := {WEL_API}.send_message_result_boolean (hwnd, {WEL_WM_CONSTANTS}.WM_COPYDATA, default_pointer, last_copydata)
							-- The window of the process has been found, stop enumerating.
						last_command_reached := True
						Result := False
					end
				end
			end
		end

feature {NONE} -- C functions

	cwel_enum_windows_procedure (cur_obj: like Current; callback: POINTER) is
			-- SDK EnumWindows
		external
			"C signature (EIF_OBJECT, EIF_POINTER) use %"wel_enum_child_windows.h%""
		end

	cwin_get_window_text_length (hwnd: POINTER): INTEGER is
			-- SDK GetWindowTextLength
		external
			"C [macro %"windows.h%"] (HWND): EIF_INTEGER"
		alias
			"GetWindowTextLength"
		end

	cwin_get_window_text (hwnd, str: POINTER; len: INTEGER): INTEGER is
			-- SDK GetWindowText
		external
			"C [macro %"windows.h%"] (HWND, LPTSTR, int): EIF_INTEGER"
		alias
			"GetWindowText"
		end

	c_hwnd_broadcast: POINTER is
			-- HWND_BROADCAST
		external
			"C [macro <windows.h>]"
		alias
			"HWND_BROADCAST"
		end

	c_new_copydatastruct (a_cmd: POINTER; a_size: INTEGER): POINTER is
			-- New copydatastruct
		external
			"C inline"
		alias
			"[
				COPYDATASTRUCT* data;
				if (data = (COPYDATASTRUCT*) malloc (sizeof (COPYDATASTRUCT)))
				{
					data->cbData = $a_size;
					data->lpData = $a_cmd;
					return data;
				}
				else
				{
					return NULL;
				}
			]"
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

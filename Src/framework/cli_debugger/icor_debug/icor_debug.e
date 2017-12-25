note
	description: "Represents the COM object ICorDebug"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG

inherit
	ICOR_OBJECT
		redefine
			dispose
		end

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	initialize
		do
			last_call_success := cpp_initialize (item)
		end

	terminate
			-- Terminate current ICorDebug
			-- this will close access to .Net COM debugger
		local
			retried: BOOLEAN
			n: INTEGER
 		do
 			if not retried then
				last_call_success := cpp_terminate (item)
				n := {CLI_COM}.release (item)

				last_icd_managed_callback.terminate_callback
				last_icd_unmanaged_callback.terminate_callback
				last_icd_managed_callback := Void
				last_icd_unmanaged_callback := Void
 			end
 		rescue
 			retried := True
 			retry
		end

	create_process (a_command_line: READABLE_STRING_GENERAL; a_working_directory: PATH; a_ns_env: detachable NATIVE_STRING): POINTER
			-- Pointer on the freshly creared ICorDebugProcess
		require
			not_empty_command_line: a_command_line /= Void and then not a_command_line.is_empty
			not_empty_working_directory: a_working_directory /= Void and then not a_working_directory.is_empty
		local
			icordebug_process: POINTER
			l_hr: INTEGER
			create_flags: INTEGER
			p_cmd,
			p_cwd,
			p_env: POINTER
			h: like last_icor_debug_process_handle
		do
			create process_info.make

				--| Flags
			create_flags := create_flags | cwin_create_new_console
--			create_flags := create_flags | cwin_debug_only_this_process

				--| Parameters
			p_cmd := (create {UNI_STRING}.make (a_command_line)).item
			p_cwd := (create {UNI_STRING}.make (a_working_directory.name)).item
			if a_ns_env /= Void and then not a_ns_env.is_empty then
				create_flags := create_flags | cwin_create_unicode_environment
				p_env := a_ns_env.item
			end

				--| Call
			last_call_success := cpp_createprocess (item,
										Default_pointer,
										p_cmd,
										Default_pointer,
										Default_pointer,
										(True).to_integer,
										create_flags,
										p_env,
										p_cwd,
										startup_info.item,
										process_info.item,
										cwin_debug_no_specials_options,
										$icordebug_process
									)
			if last_call_succeed then
				last_icor_debug_process_id := process_info.process_id

				Result := icordebug_process
				l_hr := {ICOR_DEBUG_PROCESS}.cpp_get_handle (icordebug_process, $h)
				last_icor_debug_process_handle := h
			else
				last_icor_debug_process_id     := 0
				last_icor_debug_process_handle := default_pointer
			end
		end

	debug_active_process (p_id: INTEGER; win32_attach: BOOLEAN): ICOR_DEBUG_PROCESS
			-- Debug process indentified by `p_id' and return the Process object.
		local
			icordebug_process: POINTER
		do
			last_call_success := cpp_debug_active_process (item, p_id, win32_attach.to_integer, $icordebug_process)
			if last_call_succeed then
				create Result.make_by_pointer (icordebug_process)
			end
		end

	set_managed_handler (a_cordebug_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK)
		do
			last_icd_managed_callback := a_cordebug_managed_callback
			last_call_success := cpp_set_managed_handler (item, last_icd_managed_callback.item)
		ensure
			success: last_call_success = 0
		end

	set_unmanaged_handler (a_cordebug_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK)
		do
			last_icd_unmanaged_callback := a_cordebug_unmanaged_callback
			last_call_success := cpp_set_unmanaged_handler (item, last_icd_unmanaged_callback.item)
		ensure
			success: last_call_success = 0
		end

	get_process (a_process_id: INTEGER): ICOR_DEBUG_PROCESS
		local
			p: POINTER
		do
			last_call_success := cpp_get_process (item, a_process_id, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

feature -- Disposable

	dispose
		do
			last_call_success := cpp_terminate (item)
			Precursor
		end

feature {ICOR_EXPORTER} -- Access

	clean_data
			-- Clean used data for the previous debugging session
		local
			l_hr: INTEGER
		do
			if process_info /= Void then
				l_hr := cwin_close_handle (process_info.process_handle)
				l_hr := cwin_close_handle (process_info.thread_handle)
				process_info := Void
			end
		end

feature {NONE} -- Implementation

	cpp_initialize (obj: POINTER): INTEGER
			-- Call `ICorDebug->Initialize'.
		external
			"[
				C++ ICorDebug signature 
					(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Initialize"
		ensure
			is_class: class
		end

	cpp_createprocess (obj: POINTER;
						a_name, a_cmdline, a_sec_process_attrib, a_sec_thread_attrib: POINTER;
						a_inherit_handle: INTEGER;
						a_flag: INTEGER;
						a_environnement, a_directory, a_startup_info, a_process_info: POINTER;
					 	a_cordebug_createprocess_flags: INTEGER;
						icordebugprocess: TYPED_POINTER [POINTER]
						): INTEGER
			-- Call `ICorDebug->CreateProcess'.
		external
			"[
				C++ ICorDebug signature
					(LPCWSTR, LPWSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, 
					BOOL, DWORD, PVOID, LPCWSTR, LPSTARTUPINFOW, LPPROCESS_INFORMATION, 
					CorDebugCreateProcessFlags, ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateProcess"
		ensure
			is_class: class
		end

	cpp_terminate (obj: POINTER): INTEGER
			-- Call `ICorDebug->Terminate'.
		external
			"[
				C++ ICorDebug signature(): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"Terminate"
		ensure
			is_class: class
		end

	cpp_set_managed_handler (obj: POINTER; a_icordebug_managed_callback: POINTER): INTEGER
		external
			"[
				C++ ICorDebug signature(ICorDebugManagedCallback*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetManagedHandler"
		ensure
			is_class: class
		end

	cpp_set_unmanaged_handler (obj: POINTER; a_icordebug_unmanaged_callback: POINTER): INTEGER
		external
			"[
				C++ ICorDebug signature(ICorDebugUnmanagedCallback*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetUnmanagedHandler"
		ensure
			is_class: class
		end

	cpp_get_process (obj: POINTER; a_process_id: INTEGER; a_p_process: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebug signature(DWORD, ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetProcess"
		ensure
			is_class: class
		end

feature {NONE} -- Implementation

	cpp_debug_active_process (obj: POINTER; p_id: INTEGER; win32_attach: INTEGER; icordebugprocess: TYPED_POINTER [POINTER]): INTEGER
			-- Call `ICorDebug->DebugActiveProcess'.
		external
			"[
				C++ ICorDebug signature(DWORD, BOOL, ICorDebugProcess**): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"DebugActiveProcess"
		ensure
			is_class: class
		end

feature -- ICorDebugProcess handle

	last_icor_debug_process_handle: POINTER
			-- Handle on the process debugged

	last_icor_debug_process_id: INTEGER
			-- Process ID of the created process

feature {NONE} -- Implementation routines

	last_icd_managed_callback: detachable ICOR_DEBUG_MANAGED_CALLBACK
		-- Last ICorDebugManagedCallback associated with Current

	last_icd_unmanaged_callback: detachable ICOR_DEBUG_UNMANAGED_CALLBACK
		-- Last ICorDebugUnmanagedCallback associated with Current

	process_info: detachable WEL_PROCESS_INFO
			-- Process information

	startup_info: WEL_STARTUP_INFO
			-- Process startup information
		do
			create Result.make
			Result.initialize
		ensure
			Result_attached: Result /= Void
		end

	cwin_create_new_console: INTEGER
			-- SDK CREATE_NEW_CONSOLE constant
		external
			"C macro use %"cli_debugger_headers.h%" "
		alias
			"CREATE_NEW_CONSOLE"
		end

	cwin_create_unicode_environment: INTEGER
			-- SDK CREATE_UNICODE_ENVIRONMENT constant
			-- Environment variables passed to new process uses Unicode characters instead of ANSI characters.
		external
			"C macro use %"cli_debugger_headers.h%" "
		alias
			"CREATE_UNICODE_ENVIRONMENT"
		end

	cwin_debug_only_this_process: INTEGER
			-- SDK DEBUG_ONLY_THIS_PROCESS constant
		external
			"C macro use %"cli_debugger_headers.h%" "
		alias
			"DEBUG_ONLY_THIS_PROCESS"
		end

	cwin_debug_no_specials_options: INTEGER
			-- SDK DEBUG_NO_SPECIAL_OPTIONS constant
		external
			"C macro use %"cli_debugger_headers.h%" "
		alias
			"DEBUG_NO_SPECIAL_OPTIONS"
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

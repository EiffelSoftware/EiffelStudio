indexing
	description: "Represents the COM object ICorDebug"
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

	initialize is 
		do
			last_call_success := cpp_initialize (item)
		end

	terminate is
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
	
	create_process (a_command_line, a_working_directory: STRING): POINTER is 
			-- Pointer on the freshly creared ICorDebugProcess
		require
			non_void_command_line: a_command_line /= Void
			not_empty_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void
			not_empty_working_directory: not a_working_directory.is_empty
		local
			icordebug_process: POINTER
			l_hr: INTEGER
		do
			create process_info.make
			last_call_success := cpp_createprocess (item, 
										Default_pointer,
										(create {UNI_STRING}.make (a_command_line)).item,
										Default_pointer,
										Default_pointer,
										(True).to_integer,
										cwin_create_new_console,
--										cwin_debug_only_this_process,
										Default_pointer,
										(create {UNI_STRING}.make (a_working_directory)).item,
										startup_info.item, 
										process_info.item,
										cwin_debug_no_specials_options,
										$icordebug_process
									)
			if last_call_succeed then
				Result := icordebug_process
				l_hr := {ICOR_DEBUG_PROCESS}.cpp_get_handle (icordebug_process, $last_icor_debug_process_handle)
			end
		end

	set_managed_handler (a_cordebug_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK) is
		do
			last_icd_managed_callback := a_cordebug_managed_callback
			last_call_success := cpp_set_managed_handler (item, last_icd_managed_callback.item)
		ensure
			success: last_call_success = 0
		end

	set_unmanaged_handler (a_cordebug_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK) is
		do
			last_icd_unmanaged_callback := a_cordebug_unmanaged_callback
			last_call_success := cpp_set_unmanaged_handler (item, last_icd_unmanaged_callback.item)
		ensure
			success: last_call_success = 0
		end

	get_process (a_process_id: INTEGER): ICOR_DEBUG_PROCESS is
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

	dispose is
		do
			last_call_success := cpp_terminate (item)
			Precursor
		end

feature {ICOR_EXPORTER} -- Access

	clean_data is
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

	cpp_initialize (obj: POINTER): INTEGER is
			-- Call `ICorDebug->Initialize'.
		external
			"[
				C++ ICorDebug signature 
					(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Initialize"
		end

	cpp_createprocess (obj: POINTER; 
						a_name, a_cmdline, a_sec_process_attrib, a_sec_thread_attrib: POINTER;
						a_inherit_handle: INTEGER;
						a_flag: INTEGER;
						a_environnement, a_directory, a_startup_info, a_process_info: POINTER;
					 	a_cordebug_createprocess_flags: INTEGER; 
						icordebugprocess: POINTER
						): INTEGER is
			-- Call `ICorDebug->CreateProcess'.
		external
			"[
				C++ ICorDebug signature
					(LPCWSTR, LPWSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, 
					BOOL, DWORD, PVOID, LPCWSTR, LPSTARTUPINFOW, LPPROCESS_INFORMATION, 
					CorDebugCreateProcessFlags, ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateProcess"
		end

	cpp_terminate (obj: POINTER): INTEGER is
			-- Call `ICorDebug->Terminate'.
		external
			"[
				C++ ICorDebug signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Terminate"
		end

	cpp_set_managed_handler (obj: POINTER; a_icordebug_managed_callback: POINTER): INTEGER is
		external
			"[
				C++ ICorDebug signature(ICorDebugManagedCallback*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"SetManagedHandler"
		end
		
	cpp_set_unmanaged_handler (obj: POINTER; a_icordebug_unmanaged_callback: POINTER): INTEGER is
		external
			"[
				C++ ICorDebug signature(ICorDebugUnmanagedCallback*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"SetUnmanagedHandler"
		end		

	cpp_get_process (obj: POINTER; a_process_id: INTEGER; a_p_process: POINTER): INTEGER is
		external
			"[
				C++ ICorDebug signature(DWORD, ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetProcess"
		end		

feature -- ICorDebugProcess handle

	last_icor_debug_process_handle: INTEGER
			-- Handle on the process debugged

feature {NONE} -- Implementation routines

	last_icd_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK
		-- Last ICorDebugManagedCallback associated with Current

	last_icd_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK
		-- Last ICorDebugUnmanagedCallback associated with Current
	
	process_info: WEL_PROCESS_INFO
			-- Process information
	
	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		do
			create Result.make
			Result.initialize
		end

	cwin_create_new_console: INTEGER is
				-- SDK CREATE_NEW_CONSOLE constant
			external
				"C macro use %"cli_headers.h%" "
			alias
				"CREATE_NEW_CONSOLE"
			end

	cwin_debug_only_this_process: INTEGER is
				-- SDK DEBUG_ONLY_THIS_PROCESS constant
			external
				"C macro use %"cli_headers.h%" "
			alias
				"DEBUG_ONLY_THIS_PROCESS"
			end

	cwin_debug_no_specials_options: INTEGER is
				-- SDK DEBUG_NO_SPECIAL_OPTIONS constant
			external
				"C macro use %"cli_headers.h%" "
			alias
				"DEBUG_NO_SPECIAL_OPTIONS"
			end

end -- class ICOR_DEBUG


note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_PROCESS

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- Access

	get_id: INTEGER
			-- Win32 Process ID of the process
		do
			set_last_call_success (cpp_get_id (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_handle: POINTER
			-- GetHandle returns a handle to the process
		do
			set_last_call_success (cpp_get_handle (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_thread (a_thread_id: INTEGER): ICOR_DEBUG_THREAD
			-- Debuggee Thread for `a_thread_id'
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_thread (item, a_thread_id, $p))
			if p /= default_pointer then
				Result := new_thread (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_app_domains: ICOR_DEBUG_APP_DOMAIN_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_app_domains (item, $p))
			if p /= default_pointer then
				Result := new_app_domain_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_helper_thread_id: INTEGER
			-- Win32 Thread ID of the HelperThread
		do
			set_last_call_success (cpp_get_helper_thread_id (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Get Handle

	frozen cpp_get_handle (obj: POINTER; a_p_handle: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(HPROCESS *): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"GetHandle"
		ensure
			is_class: class
		end

feature {NONE} -- Implementation

	cpp_get_id (obj: POINTER; a_p_id: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetID"
		ensure
			is_class: class
		end

	cpp_get_thread (obj: POINTER; a_thread_id: INTEGER; a_p_thread: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD, ICorDebugThread**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetThread"
		ensure
			is_class: class
		end

	cpp_enumerate_app_domains (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(ICorDebugAppDomainEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateAppDomains"
		ensure
			is_class: class
		end

	cpp_get_helper_thread_id (obj: POINTER; a_p_id: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetHelperThreadID"
		ensure
			is_class: class
		end


end

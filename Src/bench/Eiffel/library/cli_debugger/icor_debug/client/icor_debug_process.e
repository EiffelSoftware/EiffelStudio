indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_PROCESS

inherit
	ICOR_DEBUG_CONTROLLER
		export 
			{ANY} item
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	get_id: INTEGER is
			-- Win32 Process ID of the process
		do
			last_call_success := cpp_get_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_handle: POINTER is
			-- GetHandle returns a handle to the process
		do
			last_call_success := cpp_get_handle (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_thread (a_thread_id: INTEGER): ICOR_DEBUG_THREAD is
			-- Debuggee Thread for `a_thread_id'
		local
			p: POINTER			
		do
			last_call_success := cpp_get_thread (item, a_thread_id, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end		

	enumerate_app_domains: ICOR_DEBUG_APP_DOMAIN_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_app_domains (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	get_helper_thread_id: INTEGER is
			-- Win32 Thread ID of the HelperThread
		do
			last_call_success := cpp_get_helper_thread_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Get Handle

	frozen cpp_get_handle (obj: POINTER; a_p_handle: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugProcess signature(HPROCESS *): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"GetHandle"
		end
	
feature {NONE} -- Implementation

	cpp_get_id (obj: POINTER; a_p_id: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetID"
		end
		
	cpp_get_thread (obj: POINTER; a_thread_id: INTEGER; a_p_thread: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugProcess signature(DWORD, ICorDebugThread**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetThread"
		end		

	cpp_enumerate_app_domains (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugProcess signature(ICorDebugAppDomainEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateAppDomains"
		end

	cpp_get_helper_thread_id (obj: POINTER; a_p_id: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetHelperThreadID"
		end

end -- class ICOR_DEBUG_PROCESS


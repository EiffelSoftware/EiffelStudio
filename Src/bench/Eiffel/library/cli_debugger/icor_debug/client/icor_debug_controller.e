indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CONTROLLER

inherit
	ICOR_OBJECT
		export
			{EIFNET_DEBUGGER_SYNCHRO} item
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	stop (a_timeout: INTEGER) is
			-- Stop performs a cooperative stop on all threads running managed
			-- code in the process.  Threads running unmanaged code are
			-- suspended .  If the cooperative stop fails due to a deadlock, all 
			-- threads are suspended (and E_TIMEOUT is returned)
			--
			-- NOTE: This function is the one function in the debugging API
			-- that is synchronous. When Stop returns with S_OK, the process
			-- is stopped. (No callback will be given to notify of the stop.)
			-- The debugger must call Continue when it wishes to allow
			-- the process to resume running.

			-- NOTA: this may be only running "managed" code are suspended ...
			-- The doc is not clear on that point.
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[>] ICOR_DEBUG_CONTROLLER.stop ("+a_timeout.out+")%N")
			end
			last_call_success := cpp_stop (item, a_timeout)
		end

	continue (a_f_is_out_of_band: BOOLEAN) is
			-- NOTA: what about is_out_of_band ... processing ?
		local
			retried: BOOLEAN
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[>] ICOR_DEBUG_CONTROLLER.continue ("+a_f_is_out_of_band.out+")%N")
			end
			
			if not retried then
				last_call_success := cpp_continue (item, a_f_is_out_of_band.to_integer)
			end
--		ensure
--			success: last_call_success = 0
		rescue
			retried := True
			debug ("debugger_icor_data")
				io.error.put_string ("ERROR while calling pProcess->Continue(..)%N")
			end
			retry
		end

	is_running: BOOLEAN is
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_running (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end
		
	has_queued_callbacks (a_icd_th: ICOR_DEBUG_THREAD): BOOLEAN is
			-- HasQueuedCallbacks returns TRUE if there are currently managed
			-- callbacks which are queued up for the given thread.  These
			-- callbacks will be dispatched one at a time, each time Continue
			-- is called.
			--
			-- The debugger can check this flag if it wishes to report multiple 
			-- debugging events which occur simultaneously.
			-- 
			-- If NULL is given for the pThread parameter, HasQueuedCallbacks
			-- will return TRUE if there are currently managed callbacks
			-- queued for any thread.
		local
			l_result: INTEGER
			l_icd_th_ptr: POINTER
		do
			if a_icd_th /= Void then
				l_icd_th_ptr := a_icd_th.item
			end
			last_call_success := cpp_has_queued_callbacks (item, l_icd_th_ptr, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		end

	enumerate_threads: ICOR_DEBUG_THREAD_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_threads (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		end

	detach is
		do
			last_call_success := cpp_detach (item)
		ensure
			success: last_call_success = 0
		end

	terminate (a_exitcode: INTEGER) is
			-- Terminate terminates the process (with extreme prejudice, I might add).
			
			-- NOTE: If the process or appdomain is stopped when Terminate is called,
			-- the process or appdomain should be continued using Continue so that the
			-- ExitProcess or ExitAppDomain callback is received.
		do
			last_call_success := cpp_terminate (item, a_exitcode)
		end

feature {NONE} -- Implementation

	cpp_continue (obj: POINTER; a_f_is_out_of_band: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugController signature(BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Continue"
		end

	cpp_detach (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugController signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Detach"
		end

	cpp_stop (obj: POINTER; a_timeout: INTEGER): INTEGER is
			-- Call `ICorDebugController->Stop'.
		external
			"[
				C++ ICorDebugController signature(DWORD): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Stop"
		end

	cpp_is_running (obj: POINTER; a_is_running: POINTER): INTEGER is
			-- Call `ICorDebugController->IsRunning'.
			-- IsRunning returns TRUE if the threads in the process are running freely
		external
			"[
				C++ ICorDebugController signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsRunning"
		end

	cpp_has_queued_callbacks (obj: POINTER; a_icd_th_p: POINTER; a_result: POINTER): INTEGER is
			-- Call `ICorDebugController->HasQueuedCallbacks'.
		external
			"[
				C++ ICorDebugController signature(ICorDebugThread*, BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"HasQueuedCallbacks"
		end

	cpp_terminate (obj: POINTER; a_exitcode: INTEGER): INTEGER is
			-- Call `ICorDebugController->Terminate'.
		external
			"[
				C++ ICorDebugController signature(UINT): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Terminate"
		end

	cpp_enumerate_threads (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugController signature(ICorDebugThreadEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateThreads"
		end

feature {EIFNET_DEBUGGER} -- Query

	frozen cpp_query_interface_ICorDebugController (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugController *) $obj)->QueryInterface (IID_ICorDebugController, (void **) $a_p)"
		end	
		
end -- class ICOR_DEBUG_CONTROLLER


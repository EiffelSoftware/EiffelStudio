indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CONTROLLER

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	stop (a_timeout: INTEGER) is
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[>] ICOR_DEBUG_CONTROLLER.stop ("+a_timeout.out+")%N")
			end			
			last_call_success := cpp_stop (item, a_timeout)
--		ensure
--			success: last_call_success = 0 or else last_call_success = 1
		end

	continue (a_f_is_out_of_band: BOOLEAN) is
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
		ensure
			success: last_call_success = 0
		end

	enumerate_threads: ICOR_DEBUG_THREAD_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_threads (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	detach is
		do
			last_call_success := cpp_detach (item)
		ensure
			success: last_call_success = 0
		end

	terminate (a_exitcode: INTEGER) is
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

feature {NONE, ICOR_DEBUG_MANAGED_CALLBACK} -- Query

	frozen cpp_query_interface_ICorDebugController (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugController *) $obj)->QueryInterface (IID_ICorDebugController, (void **) $a_p)"
		end	
		
end -- class ICOR_DEBUG_CONTROLLER


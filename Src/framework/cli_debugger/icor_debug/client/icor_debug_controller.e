note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_CONTROLLER

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- Access

	stop (a_timeout: INTEGER)
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
			set_last_call_success (cpp_stop (item, a_timeout))
		end

	continue (a_f_is_out_of_band: BOOLEAN)
			-- NOTA: what about is_out_of_band ... processing ?
		local
			retried: BOOLEAN
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[>] ICOR_DEBUG_CONTROLLER.continue ("+a_f_is_out_of_band.out+")%N")
			end

			if not retried then
				set_last_call_success (cpp_continue (item, a_f_is_out_of_band.to_integer))
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

	is_running: BOOLEAN
		local
			l_result: INTEGER
		do
			set_last_call_success (cpp_is_running (item, $l_result))
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	has_queued_callbacks (a_icd_th: ICOR_DEBUG_THREAD): BOOLEAN
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
			set_last_call_success (cpp_has_queued_callbacks (item, l_icd_th_ptr, $l_result))
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		end

	enumerate_threads: ICOR_DEBUG_THREAD_ENUM
		local
			l_p: POINTER
		do
			set_last_call_success (cpp_enumerate_threads (item, $l_p))
			if l_p /= default_pointer then
				Result := new_thread_enum (l_p)
			end
		end

--	set_all_threads_debug_state_as_running (a_except_thread: ICOR_DEBUG_THREAD) is
--		do
--			set_all_threads_debug_state ({ICOR_DEBUG_THREAD}.enum_cor_debug_thread_state__thread_run , a_except_thread)
--		end
--		
--	set_all_threads_debug_state_as_suspended (a_except_thread: ICOR_DEBUG_THREAD) is
--		do
--			set_all_threads_debug_state ({ICOR_DEBUG_THREAD}.enum_cor_debug_thread_state__thread_suspend , a_except_thread)
--		end		
--
--	set_all_threads_debug_state (a_state: INTEGER; a_except_thread: ICOR_DEBUG_THREAD) is
--			-- SetAllThreadsDebugState sets the current debug state of each thread.
--			-- See ICorDebugThread::SetDebugState for details.
--			--
--			-- The pExceptThisThread parameter allows you to specify one
--			-- thread which is exempted from the debug state change. Pass NULL
--			-- if you want to affect all threads.
--		local
--			p_except_th: POINTER
--		do
--			if a_except_thread /= Void then
--				p_except_th := a_except_thread.item
--			end
--			set_last_call_success (cpp_set_all_threads_debug_state (item, a_state, p_except_th))
--		end

	detach
		do
			set_last_call_success (cpp_detach (item))
		ensure
			success: last_call_success = 0
		end

	terminate (a_exitcode: INTEGER)
			-- Terminate terminates the process (with extreme prejudice, I might add).

			-- NOTE: If the process or appdomain is stopped when Terminate is called,
			-- the process or appdomain should be continued using Continue so that the
			-- ExitProcess or ExitAppDomain callback is received.
		do
			set_last_call_success (cpp_terminate (item, a_exitcode))
		end

feature {NONE} -- Implementation

	cpp_continue (obj: POINTER; a_f_is_out_of_band: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugController signature(BOOL): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"Continue"
		ensure
			is_class: class
		end

	cpp_detach (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugController signature(): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"Detach"
		ensure
			is_class: class
		end

	cpp_stop (obj: POINTER; a_timeout: INTEGER): INTEGER
			-- Call `ICorDebugController->Stop'.
		external
			"[
				C++ ICorDebugController signature(DWORD): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"Stop"
		ensure
			is_class: class
		end

	cpp_is_running (obj: POINTER; a_is_running: TYPED_POINTER [INTEGER]): INTEGER
			-- Call `ICorDebugController->IsRunning'.
			-- IsRunning returns TRUE if the threads in the process are running freely
		external
			"[
				C++ ICorDebugController signature(BOOL*): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"IsRunning"
		ensure
			is_class: class
		end

	cpp_has_queued_callbacks (obj: POINTER; a_icd_th_p: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
			-- Call `ICorDebugController->HasQueuedCallbacks'.
		external
			"[
				C++ ICorDebugController signature(ICorDebugThread*, BOOL*): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"HasQueuedCallbacks"
		ensure
			is_class: class
		end

	cpp_terminate (obj: POINTER; a_exitcode: INTEGER): INTEGER
			-- Call `ICorDebugController->Terminate'.
		external
			"[
				C++ ICorDebugController signature(UINT): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"Terminate"
		ensure
			is_class: class
		end

	cpp_enumerate_threads (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugController signature(ICorDebugThreadEnum **): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateThreads"
		ensure
			is_class: class
		end

--	cpp_set_all_threads_debug_state (obj: POINTER; a_state: INTEGER; a_p_except_thread: POINTER): INTEGER is
--		external
--			"[
--				C++ ICorDebugController signature(CorDebugThreadState, ICorDebugThread*): EIF_INTEGER
--				use "cli_debugger_headers.h"
--			]"
--		alias
--			"SetAllThreadsDebugState"
--		ensure
--			is_class: class
--		end

feature {ICOR_EXPORTER} -- Query

	frozen cpp_query_interface_ICorDebugController (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugController *) $obj)->QueryInterface (IID_ICorDebugController, (void **) $a_p)"
		ensure
			is_class: class
		end

end

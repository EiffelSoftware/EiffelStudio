note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_THREAD

inherit
	ICOR_OBJECT

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access extra

	set_debug_state_as_suspended
		do
			set_debug_state (enum_cor_debug_thread_state__thread_suspend)
		end

	set_debug_state_as_running
		do
			set_debug_state (enum_cor_debug_thread_state__thread_run)
		end

feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS
		local
			p: POINTER
		do
			last_call_success := cpp_get_process (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_id: INTEGER
		do
			last_call_success := cpp_get_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_app_domain: ICOR_DEBUG_APP_DOMAIN
		local
			p: POINTER
		do
			last_call_success := cpp_get_app_domain (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	set_debug_state (a_state: INTEGER)
			-- SetDebugState sets the current debug state of the thread.
			-- (The "current debug state"
			-- represents the debug state if the process were to be continued,
			-- not the actual current state.)
			--
			-- The normal value for this is THREAD_RUNNING.  Only the debugger
			-- can affect the debug state of a thread.  Debug states do
			-- last across continues, so if you want to keep a thread
			-- THREAD_SUSPENDed over mulitple continues, you can set it once
			-- and thereafter not have to worry about it.
		require
			state_valid: a_state = enum_cor_debug_thread_state__thread_run or else
			a_state = enum_cor_debug_thread_state__thread_suspend
		do
			last_call_success := cpp_set_debug_state (item, a_state)
		end

	get_debug_state: INTEGER
			-- GetDebugState returns the current debug state of the thread.
			-- (If the process is currently stopped, the "current debug state"
			-- represents the debug state if the process were to be continued,
			-- not the actual current state.)
		do
			last_call_success := cpp_get_debug_state (item, $Result)
		ensure
			state_valid: 	Result = enum_cor_debug_thread_state__thread_run
					or else	Result = enum_cor_debug_thread_state__thread_suspend
			success: last_call_success = 0
		end

	get_user_state: INTEGER
			-- GetUserState returns the user state of the thread, that is, the state
			-- which it has when the program being debugged examines it.	
		do
			last_call_success := cpp_get_user_state (item, $Result)
		ensure
--			state_valid: Result = enum_cor_debug_thread_state__thread_run or else
--							Result = enum_cor_debug_thread_state__thread_suspend
			success: last_call_success = 0
		end

	get_current_exception: ICOR_DEBUG_VALUE
			-- WARNING: Should be called inside Callback !
		local
			p: POINTER
		do
			last_call_success := cpp_get_current_exception (item, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end

	clear_current_exception
			-- Nota: Should be called before exception occurred
		do
			last_call_success := cpp_clear_current_exception (item)
		end

	create_stepper: ICOR_DEBUG_STEPPER
		local
			p: POINTER
			l_app_domain: ICOR_DEBUG_APP_DOMAIN
			l_enum: ICOR_DEBUG_STEPPER_ENUM
		do
			last_call_success := cpp_create_stepper (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end

			debug ("DEBUGGER_EIFNET_DATA")
				l_app_domain := get_app_domain
				l_enum := l_app_domain.enumerate_steppers
				io.error.put_string ("=== CreateStepper ===%N  --> EnumSteppers count=" + l_enum.get_count.out + "%N")
				l_enum.clean_on_dispose
				l_app_domain.clean_on_dispose
			end
		end

	enumerate_chains: ICOR_DEBUG_CHAIN_ENUM
		local
			p: POINTER
		do
			last_call_success := cpp_enumerate_chains (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	get_active_chain: ICOR_DEBUG_CHAIN
		local
			p: POINTER
		do
			last_call_success := cpp_get_active_chain (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	get_active_frame: ICOR_DEBUG_FRAME
		local
			p: POINTER
		do
			last_call_success := cpp_get_active_frame (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	create_eval: ICOR_DEBUG_EVAL
			 -- CreateEval creates an evaluation object which operates on the
			 -- given thread.  The Eval will push a new chain on the thread before
			 -- doing its computation.
			 --
			 -- Note that this interrupts the computation currently
			 -- being performed on the thread until the eval completes.
		local
			p: POINTER
		do
			last_call_success := cpp_create_eval (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	get_object: ICOR_DEBUG_VALUE
			-- Returns the runtime thread object.
		local
			p: POINTER
		do
			last_call_success := cpp_get_object (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end

feature {ICOR_EXPORTER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p_process: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetProcess"
		ensure
			is_class: class
		end

	frozen cpp_get_id (obj: POINTER; a_p_thread_id: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(DWORD*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetID"
		ensure
			is_class: class
		end

	frozen cpp_get_app_domain (obj: POINTER; a_p_app_domain: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugAppDomain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetAppDomain"
		ensure
			is_class: class
		end

	frozen cpp_set_debug_state (obj: POINTER; a_p_state: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugThread signature(CorDebugThreadState): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetDebugState"
		ensure
			is_class: class
		end

	frozen cpp_get_debug_state (obj: POINTER; a_p_state: POINTER): INTEGER
		external
			"[
				C++ ICorDebugThread signature(CorDebugThreadState*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetDebugState"
		ensure
			is_class: class
		end

	frozen cpp_get_user_state (obj: POINTER; a_p_state: POINTER): INTEGER
		external
			"[
				C++ ICorDebugThread signature(CorDebugUserState*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetUserState"
		ensure
			is_class: class
		end

	frozen cpp_get_current_exception (obj: POINTER; a_p_ex: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCurrentException"
		ensure
			is_class: class
		end

	frozen cpp_clear_current_exception (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugThread signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"ClearCurrentException"
		ensure
			is_class: class
		end

	frozen cpp_create_stepper (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugStepper**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateStepper"
		ensure
			is_class: class
		end

	frozen cpp_enumerate_chains (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugChainEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateChains"
		ensure
			is_class: class
		end

	frozen cpp_get_active_chain (obj: POINTER; a_p_active_chain: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetActiveChain"
		ensure
			is_class: class
		end

	frozen cpp_get_active_frame (obj: POINTER; a_p_active_frame: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetActiveFrame"
		ensure
			is_class: class
		end

	frozen cpp_create_eval (obj: POINTER; a_p_eval: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugEval**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateEval"
		ensure
			is_class: class
		end

	frozen cpp_get_object (obj: POINTER; a_p_obj: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugThread signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetObject"
		ensure
			is_class: class
		end

feature -- External macro (enum)

	frozen enum_cor_debug_thread_state__thread_run: INTEGER
			--
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"THREAD_RUN"
		ensure
			is_class: class
		end

	frozen enum_cor_debug_thread_state__thread_suspend: INTEGER
			--
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"THREAD_SUSPEND"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_stop_requested: INTEGER --		= 0x01,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_STOP_REQUESTED"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_suspend_requested: INTEGER --	= 0x02,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_SUSPEND_REQUESTED"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_background: INTEGER --			= 0x04,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_BACKGROUND"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_unstarted: INTEGER --			= 0x08,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_UNSTARTED"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_stopped: INTEGER --			= 0x10,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_STOPPED"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_wait_sleep_join: INTEGER --	= 0x20,
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_WAIT_SLEEP_JOIN"
		ensure
			is_class: class
		end

	enum_cor_debug_user_state__user_suspended: INTEGER --			= 0x40		
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"USER_SUSPENDED"
		ensure
			is_class: class
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

indexing
	description: "[
		]"
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

	set_debug_state_as_suspended is
		do
			set_debug_state (enum_cor_debug_thread_state__thread_suspend)
		end

	set_debug_state_as_running is
		do
			set_debug_state (enum_cor_debug_thread_state__thread_run)
		end

feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS is
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

	get_id: INTEGER is
		do
			last_call_success := cpp_get_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_app_domain: ICOR_DEBUG_APP_DOMAIN is
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

	set_debug_state (a_state: INTEGER) is
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

	get_debug_state: INTEGER is
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
		
	get_user_state: INTEGER is
			-- GetUserState returns the user state of the thread, that is, the state
			-- which it has when the program being debugged examines it.	
		do
			last_call_success := cpp_get_user_state (item, $Result)
		ensure
--			state_valid: Result = enum_cor_debug_thread_state__thread_run or else
--							Result = enum_cor_debug_thread_state__thread_suspend
			success: last_call_success = 0
		end		

	get_current_exception: ICOR_DEBUG_VALUE is
			-- WARNING: Should be called inside Callback !
		local
			p: POINTER
		do
			last_call_success := cpp_get_current_exception (item, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end

	clear_current_exception is
			-- Nota: Should be called before exception occurred
		do
			last_call_success := cpp_clear_current_exception (item)
		end

	create_stepper: ICOR_DEBUG_STEPPER is
		local
			l_p: POINTER
			l_app_domain: ICOR_DEBUG_APP_DOMAIN
			l_enum: ICOR_DEBUG_STEPPER_ENUM
		do
			last_call_success := cpp_create_stepper (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
			
			debug ("DEBUGGER_EIFNET_DATA")
				l_app_domain := get_app_domain
				l_enum := l_app_domain.enumerate_steppers
				io.error.put_string ("=== CreateStepper ===%N  --> EnumSteppers count=" + l_enum.count.out + "%N")
				l_enum.clean_on_dispose
				l_app_domain.clean_on_dispose
			end
		end

	enumerate_chains: ICOR_DEBUG_CHAIN_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_chains (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		end

	get_active_chain: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_active_chain (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end
		
	get_active_frame: ICOR_DEBUG_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_get_active_frame (item, $p)
			if last_call_succeed and then p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	create_eval: ICOR_DEBUG_EVAL is
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

	get_object: ICOR_DEBUG_VALUE is
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

	frozen cpp_get_process (obj: POINTER; a_p_process: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetProcess"
		end

	frozen cpp_get_id (obj: POINTER; a_p_thread_id: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(DWORD*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetID"
		end

	frozen cpp_get_app_domain (obj: POINTER; a_p_app_domain: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugAppDomain**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetAppDomain"
		end

	frozen cpp_set_debug_state (obj: POINTER; a_p_state: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(CorDebugThreadState): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"SetDebugState"
		end

	frozen cpp_get_debug_state (obj: POINTER; a_p_state: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(CorDebugThreadState*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetDebugState"
		end

	frozen cpp_get_user_state (obj: POINTER; a_p_state: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(CorDebugUserState*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetUserState"
		end

	frozen cpp_get_current_exception (obj: POINTER; a_p_ex: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCurrentException"
		end

	frozen cpp_clear_current_exception (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"ClearCurrentException"
		end

	frozen cpp_create_stepper (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugStepper**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateStepper"
		end

	frozen cpp_enumerate_chains (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugChainEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateChains"
		end

	frozen cpp_get_active_chain (obj: POINTER; a_p_active_chain: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetActiveChain"
		end

	frozen cpp_get_active_frame (obj: POINTER; a_p_active_frame: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetActiveFrame"
		end

	frozen cpp_create_eval (obj: POINTER; a_p_eval: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugEval**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateEval"
		end

	frozen cpp_get_object (obj: POINTER; a_p_obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugThread signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetObject"
		end

feature -- External macro (enum)

	frozen enum_cor_debug_thread_state__thread_run: INTEGER is
			-- 
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"THREAD_RUN"
		end		
		
	frozen enum_cor_debug_thread_state__thread_suspend: INTEGER is
			-- 
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"THREAD_SUSPEND"
		end
		
	enum_cor_debug_user_state__user_stop_requested: INTEGER is --		= 0x01,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_STOP_REQUESTED"
		end

	enum_cor_debug_user_state__user_suspend_requested: INTEGER is --	= 0x02,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_SUSPEND_REQUESTED"
		end

	enum_cor_debug_user_state__user_background: INTEGER is --			= 0x04,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_BACKGROUND"
		end

	enum_cor_debug_user_state__user_unstarted: INTEGER is --			= 0x08,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_UNSTARTED"
		end

	enum_cor_debug_user_state__user_stopped: INTEGER is --			= 0x10,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_STOPPED"
		end

	enum_cor_debug_user_state__user_wait_sleep_join: INTEGER is --	= 0x20,
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_WAIT_SLEEP_JOIN"
		end

	enum_cor_debug_user_state__user_suspended: INTEGER is --			= 0x40		
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"USER_SUSPENDED"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_THREAD


indexing

	description:
		"Constants for communication control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class IPC_SHARED

feature {IPC_ENGINE} -- Request constants

		-- Same as in file /ipc/shared/rqst_const.h

	Rqst_hello: INTEGER 				= 4 -- Application's handshake with ewb
	Rqst_inspect: INTEGER 				= 7 -- Object inspection
	Rqst_dump_threads: INTEGER 			= 8 -- Notification from Application.
	Rqst_dump_stack: INTEGER 			= 9 -- A general stack dump request
	Rqst_dump_variables: INTEGER 		= 10 -- Dump variable for the current feature on stack.
											 -- Defined as DUMP_VARIABLE in run-time
	Rqst_move: INTEGER 					= 12 -- Change active routine pointer
	Rqst_break: INTEGER 				= 13 -- Add/delete breakpoint
	Rqst_resume: INTEGER 				= 14 -- Resume execution
	Rqst_quit: INTEGER 					= 15 -- Application must die immediately
	Rqst_application: INTEGER 			= 17 -- Start up application (for ised)
	Rqst_load: INTEGER 					= 22 -- Load byte code information
	Rqst_bc: INTEGER 					= 23 -- Byte code transfer
	Rqst_kill: INTEGER 					= 24 -- Kill application asynchronously
	Rqst_adopt: INTEGER 				= 25 -- Adopt object
	Rqst_access: INTEGER 				= 26 -- Access object through hector
	Rqst_wean: INTEGER 					= 27 -- Wean adopted object
	Rqst_once: INTEGER 					= 28 -- Once routines inspection
	Rqst_interrupt: INTEGER 			= 29 -- Debugger asking interruption of application
	Rqst_sp_lower: INTEGER 				= 33 -- Bounds for special objects inspection
	Rqst_metamorphose: INTEGER 			= 34 -- Convert the top-level item on the operational stack from a basic type to a reference type.
	Rqst_update_breakpoints: INTEGER 	= 36 -- Debugger asking interruption of application in
											 -- order to take new breakpoint(s) into account.
	Rqst_modify_local: INTEGER 			= 37 -- Debugger asking modification of a local item
											 -- (argument/local variable/result).
	Rqst_modify_attr: INTEGER 			= 38 -- Debugger asking modification of an object attribute.
	Rqst_dynamic_eval: INTEGER 			= 39 -- Debugger asking the application to evaluate a
											 -- given feature with the given parameters.
	Rqst_application_cwd: INTEGER 		= 40 -- Set current directory for application.
	Rqst_application_env: INTEGER 		= 48 -- Set current env for application.
	Rqst_overflow_detection: INTEGER 	= 41 -- Set the call stack depth at which we warn the user.
	Rqst_change_thread: INTEGER 		= 42 -- Set the thread id to inspect.
	Rqst_set_assertion_check: INTEGER 	= 43 -- Set the assertion checking state.
	Rqst_close_debugger: INTEGER 		= 44 -- Close the debugger daemon.
	Rqst_set_ipc_param: INTEGER 		= 45 -- Set IPC parameters.
	Rqst_clear_breakpoints: INTEGER 	= 46 -- Clear breakpoints table from debuggee.
	Rqst_last_exception: INTEGER 		= 47 -- get Last exception value.	
	Rqst_new_instance: INTEGER 			= 49 -- Create new instance of class
	Rqst_rt_operation: INTEGER 			= 50 -- Invoke an `RT_EXTENSION' operation	
	Rqst_last_rtcc_info: INTEGER		= 51 -- Last RunTime CatCall information (if any)

feature {NONE} -- Resume

	Resume_cont: INTEGER				= 0 -- Continue until next breakpoint
	Resume_step: INTEGER				= 1 -- Advance one step
	Resume_next: INTEGER				= 2 -- Advance until next line

	Break_set: INTEGER					= 0 -- Activate user breakpoint	( <=> DT_SET in run-time )
	Break_remove: INTEGER				= 1 -- Remove user breakpoint ( <=> DT_REMOVE in run-time )
	Break_set_stack_depth: INTEGER		= 2 -- Activate stepinto mode ( <=> DT_SET_STACKBP in run-time )
	Break_set_stepinto: INTEGER			= 3 -- Activate stepinto mode ( <=> DT_SET_STEPINTO in run-time )

feature {NONE} -- Inspection constants

	In_address: INTEGER					= 0 -- Inspect Object at given physical addr
	In_h_addr: INTEGER					= 5 -- Inspect Object at given hector addr
	In_bit_addr: INTEGER				= 6 -- Inspect Bit object at given addr
	In_string_addr: INTEGER				= 7 -- Inspect String object at given addr

	Out_called: INTEGER					= 0 -- Check whether once routine has been called
	Out_index: INTEGER					= 2 -- Ask for result of already called once function
	Out_data_per_thread: INTEGER		= 3 -- Ask for result of already called once function per thread
	Out_data_per_process: INTEGER		= 4 -- Ask for result of already called once function per process

	Out_once_per_thread: INTEGER		= 0 -- Precised that once is per thread
	Out_once_per_process: INTEGER		= 1 -- Precised that once is per process

feature -- Rt operations

	Rtop_option: INTEGER 				= 0	-- See rqst_constant.h:RQST_RTOP_OPTION
	Rtop_exec_replay: INTEGER 			= 1	-- See rqst_constant.h:RQST_RTOP_EXEC_REPLAY
	Rtop_dump_object: INTEGER 			= 2	-- See rqst_constant.h:RQST_RTOP_DUMP_OBJECT
	Rtop_set_catcall_detection: INTEGER = 10	-- See rqst_constant.h:RQST_RTOP_SET_CATCALL_DETECTION

feature {APPLICATION_STATUS} -- Implementation

--	Pg_raise: INTEGER					= 1	-- Explicitely raised exception
--	Pg_viol: INTEGER					= 2	-- Implicitely raised exception
--	Pg_break: INTEGER					= 3	-- Breakpoint reached
--	Pg_interrupt: INTEGER				= 4	-- System execution interrupted
--	Pg_new_breakpoint: INTEGER			= 5	-- New breakpoints added while running. The application should stop
											-- to record the new breakpoints.
--	Pg_step: INTEGER					= 6	-- The application completed a step operation.
--	Pg_overflow: INTEGER				= 7	-- The application might run into a stack overflow.

		-- stack request code: same as in ipc/shared/stack.h
--	Exceptions_stack: INTEGER			= 0
--	Calls_stack: INTEGER				= 1
--	Full_stack: INTEGER					= 2
--	Locals_stack: INTEGER				= 3
--	Args_stack: INTEGER					= 4
--	Vars_stack: INTEGER					= 5
--	Once_stack: INTEGER					= 6

-- Need to be updated.
	Rqst_cont: INTEGER					= 2
	Rqst_step: INTEGER					= 3
	Rqst_next: INTEGER					= 4

feature {NONE} -- Notification event type (check eif_debug.h)

	Notif_thr_created: INTEGER			= 1
	Notif_thr_exited: INTEGER			= 2

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER				= 1
	Rep_job_done: INTEGER				= 2
	Rep_failure: INTEGER				= 3
	Rep_melt: INTEGER					= 4
	Rep_dead: INTEGER					= 5
	Rep_stopped: INTEGER				= 6
	Rep_notified: INTEGER				= 7

;indexing
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

end

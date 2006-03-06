indexing

	description:
		"Constants for communication control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class IPC_SHARED

feature {NONE} -- Request constants

		-- Same as in file /ipc/shared/rqst_const.h

	Rqst_hello: INTEGER is 4
			-- Application's handshake with ewb

	Rqst_inspect: INTEGER is 7
			-- Object inspection

	Rqst_dump_threads: INTEGER is 8
			-- Notification from Application.

	Rqst_dump_stack: INTEGER is 9
			-- A general stack dump request

	Rqst_dump_variables: INTEGER is 10
			-- Dump variable for the current feature on stack.
			-- Defined as DUMP_VARIABLE in run-time

	Rqst_move: INTEGER is 12
			-- Change active routine pointer

	Rqst_break: INTEGER is 13
			-- Add/delete breakpoint

	Rqst_resume: INTEGER is 14
			-- Resume execution

	Rqst_quit: INTEGER is 15
			-- Application must die immediately

	Rqst_application: INTEGER is 17
			-- Start up application (for ised)

	Rqst_load: INTEGER is 22
			-- Load byte code information

	Rqst_bc: INTEGER is 23
			-- Byte code transfer

	Rqst_kill: INTEGER is 24
			-- Kill application asynchronously

	Rqst_adopt: INTEGER is 25
			-- Adopt object

	Rqst_access: INTEGER is 26
			-- Access object through hector

	Rqst_wean: INTEGER is 27
			-- Wean adopted object

	Rqst_once: INTEGER is 28
			-- Once routines inspection

	Rqst_interrupt: INTEGER is 29
			-- Debugger asking interruption of application

	Rqst_sp_lower: INTEGER is 33
			-- Bounds for special objects inspection

	Rqst_metamorphose: INTEGER is 34
			-- Convert the top-level item on the operational stack from a basic type to a reference type.

	Rqst_new_breakpoint: INTEGER is 36
			-- Debugger asking interruption of application in
			-- order to take new breakpoint(s) into account.

	Rqst_modify_local: INTEGER is 37
			-- Debugger asking modification of a local item
			-- (argument/local variable/result).

	Rqst_modify_attr: INTEGER is 38
			-- Debugger asking modification of an object attribute.

	Rqst_dynamic_eval: INTEGER is 39
			-- Debugger asking the application to evaluate a
			-- given feature with the given parameters.

	Rqst_application_cwd: INTEGER is 40
			-- Set current directory for application.

	Rqst_overflow_detection: INTEGER is 41
			-- Set the call stack depth at which we warn the user.

	Rqst_change_thread: INTEGER is 42
			-- Set the thread id to inspect.

	Rqst_set_assertion_check: INTEGER is 43
			-- Set the assertion checking state.

feature {NONE} -- Resume

	Resume_cont: INTEGER is 0
			-- Continue until next breakpoint

	Resume_step: INTEGER is 1
			-- Advance one step

	Resume_next: INTEGER is 2
			-- Advance until next line

	Break_set: INTEGER is 0
			-- Activate user breakpoint			-- ( <=> DT_SET in run-time )

	Break_remove: INTEGER is 1 				-- ( <=> DT_REMOVE in run-time )
			-- Remove user breakpoint

	Break_set_stack_depth: INTEGER is 2		-- ( <=> DT_SET_STACKBP in run-time )
			-- Activate stepinto mode

	Break_set_stepinto: INTEGER is 3		-- ( <=> DT_SET_STEPINTO in run-time )
			-- Activate stepinto mode


feature {NONE} -- Inspection constants

	In_address: INTEGER is 0
			-- Inspect Object at given physical addr

	In_h_addr: INTEGER is 5
			-- Inspect Object at given hector addr

	In_bit_addr: INTEGER is 6
			-- Inspect Bit object at given addr

	In_string_addr: INTEGER is 7
			-- Inspect String object at given addr

	Out_called: INTEGER is 0
			-- Check whether once routine has been called

	Out_index: INTEGER is 2
			-- Ask for result of already called once function

	Out_data_per_thread: INTEGER is 3
			-- Ask for result of already called once function per thread

	Out_data_per_process: INTEGER is 4
			-- Ask for result of already called once function per process

	Out_once_per_thread: INTEGER is 0
			-- Precised that once is per thread

	Out_once_per_process: INTEGER is 1
			-- Precised that once is per process

feature {APPLICATION_STATUS} -- Implementation

	Pg_raise: INTEGER is 1
			-- Explicitely raised exception

	Pg_viol: INTEGER is 2
			-- Implicitely raised exception

	Pg_break: INTEGER is 3
			-- Breakpoint reached

	Pg_interrupt: INTEGER is 4
			-- System execution interrupted

	Pg_new_breakpoint: INTEGER is 5
			-- New breakpoints added while running. The application should stop
			-- to record the new breakpoints.

	Pg_step: INTEGER is 6
			-- The application completed a step operation.

	Pg_overflow: INTEGER is 7
			-- The application might run into a stack overflow.

		-- stack request code: same as in ipc/shared/stack.h
--	Exceptions_stack: INTEGER is 0
--	Calls_stack: INTEGER is 1
--	Full_stack: INTEGER is 2
--	Locals_stack: INTEGER is 3
--	Args_stack: INTEGER is 4
--	Vars_stack: INTEGER is 5
--	Once_stack: INTEGER is 6


-- Need to be updated.
	Rqst_cont: INTEGER is 2
	Rqst_step: INTEGER is 3
	Rqst_next: INTEGER is 4

feature {NONE} -- Notification event type (check eif_debug.h)

	Notif_thr_created: INTEGER is 1
	Notif_thr_exited: INTEGER is 2

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER is 1
	Rep_job_done: INTEGER is 2
	Rep_failure: INTEGER is 3
	Rep_melt: INTEGER is 4
	Rep_dead: INTEGER is 5
	Rep_stopped: INTEGER is 6;
	Rep_notified: INTEGER is 7;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

indexing

	description: 
		"Constants for communication control."
	date: "$Date$"
	revision: "$Revision $"

class IPC_SHARED
 
feature {NONE} -- Request constants

		-- Same as in file /ipc/shared/rqst_const.h

	Rqst_hello: INTEGER is 4
		-- Application's handshake with ewb

	Rqst_inspect: INTEGER is 6
		-- Object inspection

	Rqst_dump: INTEGER is 7
		-- A general stack dump request

	Rqst_move: INTEGER is 9
		-- Change active routine pointer

	Rqst_break: INTEGER is 10
		-- Add/delete breakpoint

	Rqst_resume: INTEGER is 11
		-- Resume execution

	Rqst_quit: INTEGER is 12
		-- Application must die immediately

	Rqst_application: INTEGER is 14
			-- Start up application (for ised)

	Rqst_load: INTEGER is 19
		-- Load byte code information

	Rqst_bc: INTEGER is 20
		-- Byte code transfer

	Rqst_kill: INTEGER is 21
		-- Kill application asynchronously

	Rqst_adopt: INTEGER is 22
		-- Adopt object

	Rqst_access: INTEGER is 23
		-- Access object through hector

	Rqst_wean: INTEGER is 24
		-- Wean adopted object

	Rqst_once: INTEGER is 25
		-- Once routines inspection

	Rqst_interrupt: INTEGER is 26
		-- Debugger asking interruption of application

	Rqst_sp_lower: INTEGER is 30
		-- Bounds for special objects inspection

	Rqst_metamorphose: INTEGER is 31
		-- Convert the top-level item on the operational stack from a basic type to a reference type.
	
	Rqst_new_breakpoint: INTEGER is 33
		-- Debugger asking interruption of application in
		-- order to take new breakpoint(s) into account.

	Rqst_modify_local: INTEGER is 34
		-- Debugger asking modification of a local item
		-- (argument/local variable/result).

	Rqst_modify_attr: INTEGER is 35
		-- Debugger asking modification of an object attribute.

	Rqst_dynamic_eval: INTEGER is 36
		-- Debugger asking the application to evaluate a
		-- given feature with the given parameters.

	Rqst_dump_variables: INTEGER is 37
		-- Dump variable for the current feature on stack.
		-- Defined as DUMP_VARIABLE in run-time

	Rqst_application_cwd: INTEGER is 38
		-- Set current directory for application.

	Rqst_create_ref: INTEGER is 39
		-- Create a reference based on a basic type (INTEGER => INTEGER_REF...)

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

	Out_result: INTEGER is 1
		-- Ask for result of already called once function


feature {NONE} -- Implementation

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

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER is 1
	Rep_job_done: INTEGER is 2
	Rep_failure: INTEGER is 3
	Rep_melt: INTEGER is 4
	Rep_dead: INTEGER is 5
	Rep_stopped: INTEGER is 6

	sent_jobs: HASH_TABLE [STRING, STRING] is
		once
			create Result.make (10)
		end

end

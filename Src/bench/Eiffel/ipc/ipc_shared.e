indexing

	description: 
		"Constants for communication control.";
	date: "$Date$";
	revision: "$Revision $"

class IPC_SHARED
 
feature {NONE} -- Implementation

	-- ************	
	-- *** FIXME
	-- *** Use macros (need 3.3.9 +)
	-- *** to use `include_path'  
	-- Same as in file /ipc/shared/rqst_const.h

	Rqst_application: INTEGER is 14;
		-- #define APPLICATION 14 
		-- /* Start up application (for ised) */

	Rqst_load: INTEGER is 19;
		-- #define LOAD 19
		-- /* Load byte code information */

	Rqst_bc: INTEGER is 20;
		-- #define BYTECODE 20
		-- /* Byte code transfer */

	Rqst_adopt: INTEGER is 22;
		-- #define ADOPT 22
		-- /* Adopt object */

	Rqst_access: INTEGER is 23;
		-- #define ACCESS 23
		-- /* Access object through hector */

	Rqst_wean: INTEGER is 24;
		-- #define WEAN 24
		-- /* Wean adopted object */

	Rqst_once: INTEGER is 25;
		-- #define ONCE 25
		-- /* Once routines inspection */

	Rqst_interrupt: INTEGER is 26;
		-- #define EWB_INTERRUPT 26
		-- /* Debugger asking interruption of application */

	Rqst_sp_lower: INTEGER is 30;
		-- #define SP_LOWER 30
		-- /* Bounds for special objects inspection */

	Rqst_sp_upper: INTEGER is 31;
		-- #define SP_UPPER 31
		-- /* Bounds for special objects inspection */

	Rqst_resume: INTEGER is 11;
		-- #define RESUME 11
		-- /* Resume execution */

	Resume_cont: INTEGER is 0;
		-- #define DX_CONT     0
		-- /* Continue until next breakpoint */
	Resume_step: INTEGER is 1;
		-- #define DX_STEP     1
		-- /* Advance one step */
	Resume_next: INTEGER is 2;
		-- #define DX_NEXT     2
		-- /* Advance until next line */

	Rqst_hello: INTEGER is 4;
		-- #define HELLO 4
		-- /* Application's handshake with ewb */	

	Rqst_break: INTEGER is 10;
		-- #define BREAK 10
		-- /* Add/delete breakpoint */

	Break_set: INTEGER is 0;
		-- #define DT_SET      0
		-- /* Activate breakpoint */

	Break_remove: INTEGER is 1;
		-- #define DT_REMOVE   1
		-- /* Remove breakpoint */

	Rqst_dump: INTEGER is 7;
		-- #define DUMP		7
		-- /* A general stack dump request */

	Rqst_inspect: INTEGER is 6;
		-- #define INSPECT         6
		-- /* Object inspection */

	Rqst_move: INTEGER is 9;
		-- #define MOVE                       9
		-- /* Change active routine pointer */

	In_address: INTEGER is 0;
		-- #define IN_ADDRESS      0
		-- /* Object at given physical addr */

	In_h_addr: INTEGER is 5;
		-- #define IN_H_ADDR      5
		-- /* Object at given hector addr */

	In_bit_addr: INTEGER is 6;
		-- #define IN_BIT_ADDR      6
		-- /* Bit object at given addr */

	In_string_addr: INTEGER is 7;
		-- #define IN_STRING_ADDR      7
		-- /* String object at given addr */

	Out_called: INTEGER is 0;
		-- #define OUT_CALLED		0
		-- /* Check whether once routine has been called */

	Out_result: INTEGER is 1;
		-- #define OUT_RESULT		1
		-- /* Ask for result of already called once function */

	Pg_raise: INTEGER is 1;
		-- Explicitely raised exception

	Pg_viol: INTEGER is 2;
		-- Implicitely raised exception

	Pg_break: INTEGER is 3;
		-- Breakpoint reached

	Pg_interrupt: INTEGER is 4;
		-- System execution interrupted

	Rqst_quit: INTEGER is 12;
		-- #define QUIT            12
		-- /* Application must die immediately */

	Rqst_kill: INTEGER is 21;
		-- #define KILL            21
		-- /* Kill application asynchronously */

		-- stack request code: same as in ipc/shared/stack.h
	Exceptions_stack: INTEGER is 0;
	Calls_stack: INTEGER is 1;
	Full_stack: INTEGER is 2;
	Locals_stack: INTEGER is 3;
	Args_stack: INTEGER is 4;
	Vars_stack: INTEGER is 5;
	Once_stack: INTEGER is 6;
	
	
-- Need to be updated.
	Rqst_cont: INTEGER is 2;
	Rqst_step: INTEGER is 3;
	Rqst_next: INTEGER is 4;

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER is 1;
	Rep_job_done: INTEGER is 2;
	Rep_failure: INTEGER is 3;
	Rep_melt: INTEGER is 4;
	Rep_dead: INTEGER is 5;
	Rep_stopped: INTEGER is 6;

	sent_jobs: HASH_TABLE [STRING, STRING] is
		once
			!!Result.make (10)
		end
end

-- Constants for communication control 
 
class IPC_SHARED
 
		
feature {NONE} -- For workbench requests.

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
		-- /* Local variable by number */

	Pg_raise: INTEGER is 1;
		-- Explicitely raised exception

	Pg_viol: INTEGER is 2;
		-- Implicitely raised exception

	Pg_break: INTEGER is 3;
		-- Breakpoint reached

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

feature

	sent_jobs: HASH_TABLE [STRING, STRING] is
		once
			!!Result.make (10)
		end
end

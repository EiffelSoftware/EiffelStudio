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

-- Need to be updated.
	Rqst_cont: INTEGER is 2;
	Rqst_step: INTEGER is 3;
	Rqst_next: INTEGER is 4;
	Rqst_quit: INTEGER is 5;

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER is 1;
	Rep_job_done: INTEGER is 2;
	Rep_failure: INTEGER is 3;
	Rep_melt: INTEGER is 4;

feature

	sent_jobs: HASH_TABLE [STRING, STRING] is
		once
			!!Result.make (10)
		end
end

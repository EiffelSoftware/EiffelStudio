-- Constants for communication control 
 
class IPC_SHARED
 
		
feature {NONE} -- For workbench requests.

	-- Same as in file /ipc/shared/rqst_const.h

	Rqst_run: INTEGER is 1;
	Rqst_cont: INTEGER is 2;
	Rqst_step: INTEGER is 3;
	Rqst_next: INTEGER is 4;
	Rqst_quit: INTEGER is 5;

feature {NONE} -- For workbench responses.

	-- Same as in C file: ipc/ewb/ewb.h

	Rep_db_info: INTEGER is 6;
	Rep_job_done: INTEGER is 7;
	Rep_failure: INTEGER is 8;
	Rep_melt: INTEGER is 9;

feature

	sent_jobs: HASH_TABLE [STRING, STRING] is
		once
			!!Result.make (10)
		end
end

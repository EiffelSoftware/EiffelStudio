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
			-- Start up application (for ised)

	Resume_cont: INTEGER is 0;
		-- Continue until next breakpoint

	Rqst_quit: INTEGER is 12

	Rqst_cont: INTEGER is 12

end

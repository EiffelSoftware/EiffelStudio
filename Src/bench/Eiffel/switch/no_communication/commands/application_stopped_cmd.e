indexing

	description:	
		"Command for stopped applications.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STOPPED_CMD

inherit

	E_CMD;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS

feature -- Execution

	execute is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		do
		end

end -- class APPLICATION_STOPPED_CMD

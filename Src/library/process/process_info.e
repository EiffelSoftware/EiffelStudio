indexing
	description: "Object that represents information of current process"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_INFO

inherit
	EXECUTION_ENVIRONMENT


feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		deferred
		end

end

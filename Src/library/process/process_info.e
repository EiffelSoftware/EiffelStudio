indexing
	description: "Object that represents information of current process"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_INFO

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE}all
		end

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		deferred
		end

	process_module: STRING is
			-- Module (full path) of current process
		deferred
		ensure
			result_attached: Result /= Void
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		deferred
		end

end

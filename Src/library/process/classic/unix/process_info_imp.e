indexing
	description: "Unix implementation of PROCESS_INFO"
	author: ""
	date: ""
	revision: ""

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		do
		end

	process_module: STRING is
			-- Module (full path) of current process
		do
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		do
		end

end

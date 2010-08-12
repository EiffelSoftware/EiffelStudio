note
	description: "Summary description for {REPOSITORY_LOG_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_LOG_FILTER

inherit
	DEBUG_OUTPUT
		rename
			debug_output as to_string
		end

feature -- Access

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		deferred
		end

	to_string: STRING
		deferred
		end

end

note
	description: "Task made of other tasks whose execution needs to be ordered."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SEQUENTIAL_TASK

inherit
	TASK
		undefine
			is_equal
		end

	LIST [TASK]

end

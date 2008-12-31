note
	description: "Task made of other tasks whose execution doesn't need to be ordered."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARALLEL_TASK

inherit
	TASK
		undefine
			is_equal
		end

	LIST [TASK]

end

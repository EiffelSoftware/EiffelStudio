note

	description:

		"Abstract interface for tasks that can be exectuted in steps and canceled"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class AUT_TASK

feature -- Status

	has_next_step: BOOLEAN
			-- Is there a next step to execute?
		deferred
		end

feature -- Execution

	start
			-- Start execution of task.
		require
			not_has_next_step: not has_next_step
		deferred
		end

	step
			-- Perform the next step of the task.
		require
			has_next_step: has_next_step
		deferred
		end

	cancel
			-- Cancel task.
		require
			has_next_step: has_next_step
		deferred
		ensure
			no_next_steps: not has_next_step
		end

end

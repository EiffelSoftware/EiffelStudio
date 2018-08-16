note
	description: "Summary description for {TASK}."
	date: "$Date$"
	revision: "$Revision$"

class
	TASK

create
	make

feature {NONE} -- Initialization

	make
		once
			status := 0
			name := "Initialized"
		end

feature -- Access

	status: INTEGER
		-- task status
		-- 0 Initialized
		-- 1 started
		-- 2 suspended
		-- 3 finished

	name: STRING


feature -- Change

	mark_started
		do
			status := 1
			name := "Started"
		end

	mark_suspended
		do
			status := 2
			name := "Suspended"
		end

	mark_finished
		do
			status := 3
			name := "Finished"
		end
end

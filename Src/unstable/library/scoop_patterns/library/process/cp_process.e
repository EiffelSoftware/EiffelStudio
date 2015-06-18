note
	description: "Active objects with a main loop."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_PROCESS

inherit
	CP_STARTABLE

feature -- Status report

	is_stopped: BOOLEAN
			-- Is `Current' stopped?

feature -- Basic operations

	step
			-- Perform a step in the computation.
		deferred
		end

	setup
			-- Perform initialization.
		do
		end

	cleanup
			-- Perform cleanup.
		do
		end

end

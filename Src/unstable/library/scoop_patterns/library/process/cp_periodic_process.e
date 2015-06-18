note
	description: "Runs an operation periodically."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_PERIODIC_PROCESS

inherit

	CP_INTERMITTENT_PROCESS
		redefine
			setup
		end

feature {NONE} -- Initialization

	make (a_interval: INTEGER_64)
			-- Create a new timer that runs a task periodically, with `a_interval' nanoseconds in between runs.
		require
			positive: a_interval >= 0
		do
			interval := a_interval
			create environment
		ensure
			interval_set: interval = a_interval
		end

feature -- Access

	interval: INTEGER_64
			-- The time duration between runs.

	environment: EXECUTION_ENVIRONMENT
			-- An execution environment instance.

feature -- Basic operations

	setup
			-- <Precursor>
		do
			is_stopped := False
		end

	step
			-- <Precursor>
		do
			environment.sleep (interval)
			run
		end

	stop
			-- Stop `Current'.
		do
			is_stopped := True
		end

	run
			-- Perform the actual task.
		deferred
		end

invariant
	interval_positive: interval >= 0
end

note
	description: "Interface for a platform-dependent implementation to run Boogie."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_EXECUTABLE

inherit

	E2B_SHARED_CONTEXT

feature -- Access

	input: attached E2B_VERIFIER_INPUT
			-- Input for Boogie.

	last_output: detachable STRING
			-- Output of last run of Boogie.
		deferred
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is process still running?
		deferred
		end

feature -- Element change

	set_input (a_input: attached E2B_VERIFIER_INPUT)
			-- Set `input' to `a_input'.
		do
			input := a_input
		ensure
			input_set: input = a_input
		end

feature -- Basic operations

	run
			-- Run Boogie on `input'.
		deferred
		ensure
			not_running: not is_running
		end

	run_asynchronous
			-- Run Boogie on `input'.
		deferred
		ensure
			maybe_running: is_running or not is_running
		end

	cancel
			-- Cancel execution.
		deferred
		ensure
			not_running: not is_running
		end

end

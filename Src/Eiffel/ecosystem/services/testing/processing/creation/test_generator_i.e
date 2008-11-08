indexing
	description: "[
		Automatically generates a series of test from a given configuration
		
		This will implement the Auto Test functionality of the testing service
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_GENERATOR_I

inherit
	TEST_CREATOR_I

feature -- Access

	configuration: !TEST_GENERATOR_CONF_I
		deferred
		end

feature -- Status report

	is_compiling: BOOLEAN
			-- Is `Current' compiling the project?
		require
			running: is_running
		deferred
		end

	is_executing: BOOLEAN
			-- Is `Current' executing random test cases?
		require
			running: is_running
		deferred
		end

	is_replaying_log: BOOLEAN
			-- Is `Current' replaying the log?
		require
			running: is_running
		deferred
		end

	is_minimizing_witnesses: BOOLEAN
			-- Is `Current' minimizing the input for reproducing failures?
		require
			running: is_running
		deferred
		end

	is_generating_statistics: BOOLEAN
			-- Is `Current' generating statistics?
		require
			running: is_running
		deferred
		end

end

note
	description: "[
		Interface of a configuration used to launch a test executor.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_CONF_I

inherit
	TEST_PROCESSOR_CONF_I

feature -- Access

	tests: attached DS_LINEAR [attached TEST_I]
			-- Tests to be executed
		require
			usable: is_interface_usable
			specific: is_specific
		deferred
		end

	sorter_prefix: attached STRING
			-- Prefix used to sort tests for execution
		require
			usable: is_interface_usable
		deferred
		ensure
			valid: (create {TAG_UTILITIES}).is_valid_tag (Result)
		end

	evaluator_count: NATURAL
			-- Number of evaluators to be ran simultaneously
		require
			usable: is_interface_usable
		deferred
		ensure
			positive: Result > 0
		end

feature -- Status report

	is_specific: BOOLEAN
			-- Are specific tests to be executed provided?
			--
			-- Note: if False, executor should simply test complete test suite.
		deferred
		end

end

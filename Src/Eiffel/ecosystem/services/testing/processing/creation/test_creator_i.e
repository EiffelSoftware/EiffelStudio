indexing
	description: "[
		An interface of an test factory which an arbitrary number of tests.
		
		After a test creation sessions has been launched, the factory adds new tests automatically to
		the test suite. A factory also makes there newly created available by representing a test
		collection. This collection is kept synchronized with the test suite.
		The duration of a session is be defined by the implementation or optionally by the provided
		configuration when launching.
		
		See {TEST_PROCESSOR_I} for details on the execution flow.

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATOR_I

inherit
	TEST_PROCESSOR_I
		rename
			tests as created_tests,
			argument as configuration,
			is_valid_argument as is_valid_configuration
		end

feature -- Access

	configuration: !TEST_CREATOR_CONF_I
			-- Configuration used in current test creation run
		require else
			usable: is_interface_usable
			running: is_running
		deferred
		end

feature {NONE} -- Query		

	is_valid_typed_argument (a_arg: like configuration): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_usable: Result implies a_arg.is_interface_usable
		end

end

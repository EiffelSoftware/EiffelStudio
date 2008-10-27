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
	EIFFEL_TEST_FACTORY_I

inherit
	EIFFEL_TEST_PROCESSOR_I
		rename
			tests as created_tests,
			argument as configuration,
			is_valid_argument as is_valid_configuration
		end

feature -- Access

	configuration: !EIFFEL_TEST_CONFIGURATION_I
			-- Configuration used in current test creation run
		require else
			usable: is_interface_usable
			running: is_running
		deferred
		end

feature -- Query		

	is_valid_typed_argument (a_arg: like configuration; a_test_suite: like test_suite): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_usable: Result implies a_arg.is_interface_usable
		end

end

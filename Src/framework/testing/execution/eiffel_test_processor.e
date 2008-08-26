indexing
	description: "[
		Objects that provide common functionality needed for implementations of {EIFFEL_TEST_PROCESSOR_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR

inherit
	EIFFEL_TEST_PROCESSOR_I

	EIFFEL_TEST_COLLECTION
		rename
			are_tests_available as is_test_suite_valid
		undefine
			events
		end

	EIFFEL_TEST_SUITE_OBSERVER

feature -- Access

	test_suite: !EIFFEL_TEST_SUITE_S
			-- <Precursor>
		do
			Result ?= internal_test_suite
		end

feature {NONE} -- Access

	internal_test_suite: ?like test_suite
			-- Internal storage for `test_suite'

feature -- Status report

	is_test_suite_valid: BOOLEAN
			-- <Precursor>
		do
			Result := internal_test_suite /= Void and then
			          internal_test_suite.is_interface_usable and then
			          internal_test_suite.is_project_initialized
		end

	is_idle: BOOLEAN
			-- <Precursor>

	is_stop_requested: BOOLEAN
			-- <Precursor>

feature -- Status setting

	request_stop is
			-- <Precursor>
		do
			is_stop_requested := True
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	frozen proceed is
			-- <Precursor>
		do
			is_idle := True
			proceed_process
			is_idle := False
		end

feature {NONE} -- Status setting

	attach_test_suite (a_test_suite: like test_suite)
			-- <Precursor>
		do
			if internal_test_suite /= Void then
				internal_test_suite.disconnect_events (Current)
			end
			internal_test_suite := a_test_suite
			internal_test_suite.connect_events (Current)
		end

	proceed_process is
			-- Proceed with actual task
		require
			not_idle: not is_idle
		deferred
		end


end

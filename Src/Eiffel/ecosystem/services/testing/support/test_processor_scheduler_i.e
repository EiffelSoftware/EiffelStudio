note
	description: "[
		Interface of a scheduler which manages a pool of processors and periodically calls
		{TEST_PROCESSOR_I}.proceed allowing the processor to progress with theyr work. Any scheduler
		should make use of {TEST_PROCESSOR_I}.sleep_time as an indicator for how long a processor should
		to be left in an idle state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_PROCESSOR_SCHEDULER_I

inherit
	USABLE_I

feature -- Access

	test_suite: TEST_SUITE_S
			-- Test suite service using `Current' to schedule processors
		require
			usable: is_interface_usable
		deferred
		ensure
			result_usable: Result.is_interface_usable
		end

feature -- Basic operations

	launch_processor (a_processor: TEST_PROCESSOR_I; a_conf: TEST_PROCESSOR_CONF_I)
			-- Launch test processor and notify all observers
		require
			usable: is_interface_usable
			processor_ready: a_processor.is_ready
			processor_suitable: a_processor.is_valid_configuration (a_conf)
		deferred
		end

end

indexing
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

	tests: !DS_LINEAR [!TEST_I]
			-- Tests to be executed
		require
			usable: is_interface_usable
			specific: is_specific
		deferred
		end

feature -- Status report

	is_specific: BOOLEAN
			-- Are specific tests to be executed provided?
			--
			-- Note: if False, executor should simply test complete test suite.
		deferred
		end

end

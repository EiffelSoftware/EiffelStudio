indexing
	description: "[
		Interface for a eiffe test factory that creates manual test cases.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_MANUAL_FACTORY_I

inherit
	EIFFEL_TEST_FACTORY_I

feature -- Access

	configuration: !EIFFEL_TEST_MANUAL_CONFIGURATION_I
			-- <Precursor>
		deferred
		end

end

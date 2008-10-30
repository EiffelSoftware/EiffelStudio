indexing
	description: "Summary description for {EIFFEL_TEST_GENERATOR_CONFIGURATION_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_GENERATOR_CONFIGURATION_I

inherit
	EIFFEL_TEST_CONFIGURATION_I

feature -- Access

	arguments: !DS_LIST [!STRING]
			-- Arguments passed to AutoTest
		require
			usable: is_interface_usable
		deferred
		ensure
			not_contains_empty: not Result.there_exists (agent {!STRING}.is_empty)
		end

end

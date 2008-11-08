indexing
	description: "[
		Interface for a eiffe test factory that creates manual test cases.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_MANUAL_CREATOR_I

inherit
	TEST_CREATOR_I

feature -- Access

	configuration: !TEST_MANUAL_CREATOR_CONF_I
			-- <Precursor>
		deferred
		end

end

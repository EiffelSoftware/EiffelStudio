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
		redefine
			conf_type
		end

feature {NONE} -- Typing

	conf_type: !TEST_MANUAL_CREATOR_CONF_I
			-- <Precursor>
		do
		end

end

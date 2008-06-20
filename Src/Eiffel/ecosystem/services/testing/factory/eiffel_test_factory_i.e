indexing
	description: "[
		Creates new manual eiffel test
		
		Uses an eiffel test configuration to create an empty test
		routine which can then be completed by the user.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_FACTORY_I

inherit
	TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]

end

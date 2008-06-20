indexing
	description: "[
		Abstract factory for creating new tests
		
		A factory tries to create on or more tests for a given
		configuration. The creation of the tests is asynchronously
		so a call back procedure if used to notify when a new test
		has been created.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_FACTORY_I [G -> TEST_CONFIGURATION_I]

inherit
	USABLE_I

feature -- Status report

	can_create_test: BOOLEAN
			-- Is `Current' in a state where it is ready to create tests?
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	is_valid_configuration (a_config: !G): BOOLEAN
			-- Is `a_config' a valid configuration for creating tests?
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Factory

	create_test (a_config: !G; a_call_back: ?PROCEDURE [ANY, TUPLE [TEST_I]])
			-- Create new test asynchronously
			--
			-- `a_config': configuration used to create new tests
			-- `a_call_back': procedure called each time a new test has been created
		require
			is_interface_usable: is_interface_usable
			can_create_test: can_create_test
			valid_configuration: is_valid_configuration (a_config)
		deferred
		end

end

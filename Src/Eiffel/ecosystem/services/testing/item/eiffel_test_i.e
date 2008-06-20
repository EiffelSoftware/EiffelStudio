indexing
	description: "[
		Interface representing an eiffel test
		
		Eiffel tests are routines in a class inheriting from
		TEST_SET.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_I

inherit
	TEST_I

feature -- Access

	parent_name: !STRING
			-- Syntactical representation of class in which `routine'
			-- `routine' is located
		require
			usable: is_interface_usable
		deferred
		end

	outcomes: !DS_BILINEAR [!EIFFEL_TEST_OUTCOME_I]
			-- <Precursor>
		deferred
		end

end

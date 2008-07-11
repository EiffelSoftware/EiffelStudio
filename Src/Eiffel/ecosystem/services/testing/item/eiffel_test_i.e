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
		redefine
			last_outcome
		end

feature -- Access

	parent_name: !STRING
			-- Syntactical representation of class in which `routine'
			-- `routine' is located
		require
			usable: is_interface_usable
		deferred
		end

	outcomes: !DS_BILINEAR [like last_outcome]
			-- <Precursor>
		deferred
		end

	last_outcome: !EIFFEL_TEST_OUTCOME_I
			-- <Precursor>
		do
			Result ?= Precursor
		end

end

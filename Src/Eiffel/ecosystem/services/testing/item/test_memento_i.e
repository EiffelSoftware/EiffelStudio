indexing
	description: "[
		Objects that describe changes occured in {EIFFEL_TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_MEMENTO_I

inherit
	TAGABLE_MEMENTO_I

feature -- Status report

	is_outcome_added: BOOLEAN
			-- Has a new outcome been added?
		deferred
		end

	has_execution_status_changed: BOOLEAN
			-- Has execution status changed?
		deferred
		end

end

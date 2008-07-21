indexing
	description: "[
		Objects that describe changes occured in {EIFFEL_TEST_I}.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_MEMENTO_I

inherit
	TAGABLE_MEMENTO_I

feature -- Status report

	outcome_added: BOOLEAN
			-- Has a new outcome been added?
		deferred
		end

	execution_status_changed: BOOLEAN
			-- Has execution status changed?
		deferred
		end

end

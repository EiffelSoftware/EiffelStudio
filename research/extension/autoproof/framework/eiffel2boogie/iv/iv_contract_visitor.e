note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_CONTRACT_VISITOR

feature -- Visitor

	process_precondition (a_precondition: IV_PRECONDITION)
			-- Process `a_precondition'.
		require
			a_precondition_attached: attached a_precondition
		deferred
		end

	process_postcondition (a_postcondition: IV_POSTCONDITION)
			-- Process `a_postcondition'.
		require
			a_postcondition_attached: attached a_postcondition
		deferred
		end

	process_modifies (a_modifies: IV_MODIFIES)
			-- Process `a_modifies'.
		require
			a_modifies_attached: attached a_modifies
		deferred
		end

end

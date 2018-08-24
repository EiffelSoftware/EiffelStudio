note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_CONTRACT

feature -- Access

	expression: IV_EXPRESSION
			-- If this contract is an assertions, its expression;
			-- otherwise Void.
		do
		end

feature -- Visitor

	process (a_visitor: IV_CONTRACT_VISITOR)
			-- Process `a_visitor'.
		deferred
		end

end

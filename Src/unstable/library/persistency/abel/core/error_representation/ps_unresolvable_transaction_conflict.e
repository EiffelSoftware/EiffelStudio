note
	description: "Represents a transaction write conflict that can't be resolved in implicit transaction management."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_UNRESOLVABLE_TRANSACTION_CONFLICT

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "Unresolvable transaction conflict"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_unresolvable_transaction_conflict (Current)
		end

end

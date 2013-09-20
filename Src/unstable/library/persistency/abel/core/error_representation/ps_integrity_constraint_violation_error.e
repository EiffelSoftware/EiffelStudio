note
	description: "Summary description for {PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_INTEGRITY_CONSTRAINT_VIOLATION_ERROR

inherit
	PS_INVALID_OPERATION_ERROR
	redefine
		description, accept
	end

feature

	description: STRING = "Integrity constraint violation"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_integrity_constraint_violation (Current)
		end
end

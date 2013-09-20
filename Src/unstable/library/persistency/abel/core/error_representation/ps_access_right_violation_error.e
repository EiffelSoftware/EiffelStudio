note
	description: "Represents an access right violation in the backend."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ACCESS_RIGHT_VIOLATION_ERROR

inherit

	PS_INVALID_OPERATION_ERROR
	redefine
		description, accept
	end

feature

	description: STRING = "Access right violation"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_access_right_violation (Current)
		end

end

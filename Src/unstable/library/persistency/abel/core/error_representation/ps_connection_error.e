note
	description: "Represents an connection error."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CONNECTION_ERROR

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "Connection lost"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_connection_problem (Current)
		end

end

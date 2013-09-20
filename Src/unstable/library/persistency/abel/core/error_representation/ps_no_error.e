note
	description: "Instances of this class indicate that no error has occured"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_NO_ERROR

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "No error occured"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_no_error (Current)
		end

end

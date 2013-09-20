note
	description: "Summary description for {PS_INVALID_OPERATION_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_INVALID_OPERATION_ERROR

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING
			-- A human-readable string containing an error description
		do
			Result:= "Operation invalid"
		end

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_invalid_operation_error (Current)
		end
end

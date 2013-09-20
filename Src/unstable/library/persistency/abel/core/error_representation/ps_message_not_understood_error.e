note
	description: "Summary description for {PS_MESSAGE_NOT_UNDERSTOOD_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MESSAGE_NOT_UNDERSTOOD_ERROR

inherit
	PS_INVALID_OPERATION_ERROR
	redefine
		description, accept
	end

feature

	description: STRING = "Message not understood"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_message_not_understood (Current)
		end

end

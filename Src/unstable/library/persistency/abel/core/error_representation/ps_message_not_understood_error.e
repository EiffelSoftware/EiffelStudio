note
	description: "Represents an error where the backend has received a command it does not understand."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MESSAGE_NOT_UNDERSTOOD_ERROR

inherit
	PS_OPERATION_ERROR
		redefine
			tag, accept, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("Message not understood")
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_message_not_understood_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := -1
			set_description ("The requested command is malformed or invalid, or the opration is not supported by the backend.")
		end

end

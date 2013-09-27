note
	description: "Represents an error in the database backend where an external routine has failed."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EXTERNAL_ROUTINE_ERROR

inherit
	PS_OPERATION_ERROR
		redefine
			tag, accept, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("External routine error")
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_external_routine_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := -1
			set_description ("An external routine or SQL function within the database has failed.")
		end

end

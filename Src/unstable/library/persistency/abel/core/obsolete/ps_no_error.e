note
	description: "Instances of this class indicate that no error has occured. Mainly exists for void safety reasons."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_NO_ERROR

inherit
	PS_ERROR
		redefine
			tag, accept, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("No error")
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_no_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := 0
			set_description ("Everything's fine")
		end

end

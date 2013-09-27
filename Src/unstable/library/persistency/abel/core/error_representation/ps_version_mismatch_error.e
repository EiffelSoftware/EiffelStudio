note
	description: "Represents a version mismatch between stored and current object type."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_VERSION_MISMATCH_ERROR

inherit
	PS_OPERATION_ERROR
		redefine
			tag, accept, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("Version mismatch")
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_version_mismatch_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := -1
			set_description ("The format of the stored object is not compatible with the runtime type, i.e. the corresponding class has evolved.")
		end

end

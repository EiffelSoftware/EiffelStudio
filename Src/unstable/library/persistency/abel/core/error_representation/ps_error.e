note
	description: "This class is the ancestor to all objects representing an error that might occur during execution."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ERROR

inherit
	DEVELOPER_EXCEPTION
		redefine
			tag, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("Uncategorized error")
		end

	backend_error_code: INTEGER
			-- The error code returned by the backend.
			-- Always set to 0 if there is no error.
			-- If the backend doesn't support error codes, the value is -1.
		attribute
		ensure
			not_zero: Result /= 0
		end

	backend_error_message: detachable READABLE_STRING_GENERAL
			-- The original error message returned by the backend, if any.

	backend_error: detachable ANY
			-- The original error object returned by the backend, if any.

	backend_sqlstate: detachable READABLE_STRING_GENERAL
			-- The original SQLState string, in case the backend supports it.
		attribute
		ensure
			correct_length: attached Result implies Result.count = 5
		end

feature {PS_ABEL_EXPORT} -- Element change

	set_backend_error_code (a_code: like backend_error_code)
			-- Set the backend error code.
		do
			backend_error_code := a_code
		end

	set_backend_error_message (a_message: like backend_error_message)
			-- Set the backend error message.
		do
			backend_error_message := a_message
		end

	set_backend_error (error: like backend_error)
			-- Set the original backend error object
		do
			backend_error := error
		end

	set_backend_sqlstate (sqlstate: like backend_sqlstate)
			-- Set the backend SQLState
		do
			backend_sqlstate:= sqlstate
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_uncategorized_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := -1
			set_description ("Some uncategorized error has occured in the backend or within ABEL.")
		end

end

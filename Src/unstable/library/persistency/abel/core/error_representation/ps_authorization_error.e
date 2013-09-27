note
	description:
	"[
		Represents any kind of authorization error, e.g. wrong login information or an invalid authorization certificate.
		Note: You are not guaranteed to get a PS_AUTHORIZATION_ERROR for wrong login information, as some backends don't
		distinguish between a wrong login and a more general connection establishment failure.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AUTHORIZATION_ERROR

inherit
	PS_CONNECTION_SETUP_ERROR
		redefine
			tag, accept, default_create
		end

feature -- Access

	tag: IMMUTABLE_STRING_32
			-- A short message describing what the current error is
		once
			create Result.make_from_string_8 ("Authorization failed")
		end

feature {PS_ERROR_VISITOR} -- Visitor pattern

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_authorization_error (Current)
		end

feature {NONE} -- Initialization

	default_create
			-- Create a new instance of this error
		do
			backend_error_code := -1
			set_description ("An error occurred during authorization. Possible causes might be wrong login data or an invalid authorization certificate")
		end
end

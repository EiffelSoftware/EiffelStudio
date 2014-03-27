note
	description: "Object view that represent activation data"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACTIVATION_VIEW


feature -- Access

	email: detachable READABLE_STRING_32
			-- User email

	token: detachable READABLE_STRING_32
			-- Token validator

	error_message: detachable READABLE_STRING_32
			-- Error message

feature -- Status Report

	is_valid_form: BOOLEAN
			-- an activation form is valid if
			-- email and token are setted.
		do
			if attached email as l_email and then not l_email.is_empty and then
			   attached token as l_token and then not l_token.is_empty then
			   	Result := True
			end
		end

feature -- Element Change

	set_email (a_email: like email)
			-- Set `email' with `a_email'
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_token (a_token: like token)
			-- Set `token' with `a_token'
		do
			token := a_token
		ensure
			token_set: token = a_token
		end

	set_error_message (a_message: like error_message)
			-- Set `error_message' with `a_message'
		do
			error_message := a_message
		ensure
			ensure_set: error_message = a_message
		end
end

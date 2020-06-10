note
	description: "Object view that represent Email data"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_VIEW

feature -- Access

	email: detachable STRING_32
			-- new email.

	check_email: detachable STRING_32
			-- Check email.

	token: detachable STRING_32
			-- Token to confirm new email.		

	is_valid_form: BOOLEAN
			-- Are the current values valid?
		local
			l_errors: STRING_TABLE [READABLE_STRING_32]
		do
			create l_errors.make (0)
			if email = Void or else (attached email as l_email and then l_email.is_empty) then
				l_errors.put ("email is required", "email")
			end
			if check_email = Void or else (attached check_email as l_check_email and then l_check_email.is_empty) then
				l_errors.put ("Check email is required", "check_email")
			end
			if attached email as l_email and then attached check_email as l_check_email then
				if l_email.is_empty or else l_check_email.is_empty then
					l_errors.put ("email and Check email does not match", "check_email")
				elseif not l_email.same_string (l_check_email) then
					l_errors.put ("email and Check email does not match", "check_email")
				end
			else
				l_errors.put ("email and Check email does not match", "Check_passowrd")
			end
			if l_errors.is_empty then
				Result := True
			else
				errors := l_errors
			end
		end

feature -- Errors

	errors: detachable STRING_TABLE [READABLE_STRING_32]
			-- Hash table with errors and descriptions.

feature -- Change Element

	set_email (a_email: READABLE_STRING_32)
			-- Set `email' to `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_check_email (a_check_email: READABLE_STRING_32)
			-- Set `email' to `a_check_email'.
		do
			check_email := a_check_email
		ensure
			check_email_set: check_email = a_check_email
		end

	set_token (a_token: READABLE_STRING_32)
			-- Set `token' to `a_token'.
		do
			token := a_token
		ensure
			token_set: token = a_token
		end

	add_error (a_key: READABLE_STRING_32; a_description: READABLE_STRING_32)
			-- Add an error with key `a_key' and description `a_description'.
		local
			l_errors: like errors
		do
			l_errors := errors
			if attached l_errors then
				l_errors.force (a_description, a_key)
				errors := l_errors
			else
				create l_errors.make (0)
				l_errors.force (a_description, a_key)
				errors := l_errors
			end
		end

end

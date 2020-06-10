note
	description: "Object view that represent password data"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PASSWORD_VIEW

feature -- Access

	password: detachable STRING_32
			-- new password.

	check_password: detachable STRING_32
			-- Check password.

	is_valid_form: BOOLEAN
			-- Are the current values valid?
		local
			l_errors: STRING_TABLE [READABLE_STRING_32]
		do
			create l_errors.make (0)
			if password = Void or else (attached password as l_password and then l_password.is_empty) then
				l_errors.put ("Password is required", "password")
			end
			if check_password = Void or else (attached check_password as l_check_password and then l_check_password.is_empty) then
				l_errors.put ("Check Password is required", "check_password")
			end
			if attached password as l_password and then attached check_password as l_check_password then
				if l_password.is_empty or else l_check_password.is_empty then
					l_errors.put ("Password and Check password does not match", "Check_password")
				elseif not l_password.same_string (l_check_password) then
					l_errors.put ("Password and Check password does not match", "Check_passowrd")
				end
			else
				l_errors.put ("Password and Check password does not match", "Check_passowrd")
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


	put_error (new: READABLE_STRING_32; key: READABLE_STRING_GENERAL)
		local
			l_errors: like errors
		do
			l_errors := errors
			if attached l_errors then
				l_errors.force (new, key)
			else
				create l_errors.make (1)
				l_errors.force (new, key)
			end
			errors := l_errors
		end

feature -- Change Element

	set_password (a_password: READABLE_STRING_32)
			-- Set `password' to `a_password'.
		do
			password := a_password
		ensure
			password_set: password = a_password
		end

	set_check_password (a_check_password: READABLE_STRING_32)
			-- Set `password' to `a_check_password'.
		do
			check_password := a_check_password
		ensure
			check_password_set: check_password = a_check_password
		end

end

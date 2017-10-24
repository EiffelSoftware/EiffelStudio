note
	description: "[
		Data to be used for filling a user register request.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_REGISTER

create
	make

feature {NONE} -- Initialization

	make
			-- create an object user register.
		do
				-- default values.
			question := 1
			create {STRING_32}answer.make_from_string ("Earth")
		end

feature -- Access

	first_name: detachable READABLE_STRING_32
			-- Current first name, if any.

	last_name: detachable READABLE_STRING_32
			-- Current last name, if any.

	user_name: detachable READABLE_STRING_32
			-- Current user name, if any.

	email: detachable READABLE_STRING_32
			-- Current email, if any.

	password: detachable READABLE_STRING_32
			-- Current password, if any.

	check_password: detachable READABLE_STRING_32
			-- Current check password, if any.

feature  {ESA_SUPPORT_USER_REGISTER} -- Defautl properties

	question: INTEGER
			-- Current selected question.

	answer: READABLE_STRING_32
			-- Current answer, if any.

feature -- Change Element

	set_first_name (a_first_name: like first_name)
			-- Set `first_name' with `a_first_name'.
		do
			first_name := a_first_name
		ensure
			first_name_set: first_name = a_first_name
		end

	set_last_name (a_last_name: like last_name)
			-- Set `last_name' with `a_last_name'.
		do
			last_name := a_last_name
		ensure
			last_name_set: last_name = a_last_name
		end

	set_user_name (a_user_name: like user_name)
			-- Set `user_name' with `a_user_name'.
		do
			user_name := a_user_name
		ensure
			user_name_set: user_name = a_user_name
		end

	set_email (a_email: like email)
			-- Set `email' with `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_password (a_password: like password)
			-- Set `password' with `a_password'.
		do
			password := a_password
		ensure
			password_set: password = a_password
		end

	set_check_password (a_check_password: like check_password)
			-- Set `check_password' with `a_check_password'.
		do
			check_password := a_check_password
		ensure
			check_password_set: check_password = a_check_password
		end

end

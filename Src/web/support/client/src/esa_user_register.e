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
			create {IMMUTABLE_STRING_32} answer.make_from_string ("Earth")
		end

feature -- Access

	user_name: detachable IMMUTABLE_STRING_32
			-- Current user name, if any.

	email: detachable IMMUTABLE_STRING_32
			-- Current email, if any.

	password: detachable IMMUTABLE_STRING_32
			-- Current password, if any.

	check_password: detachable IMMUTABLE_STRING_32
			-- Current check password, if any.

	first_name: detachable IMMUTABLE_STRING_32
			-- Current first name, if any.

	last_name: detachable IMMUTABLE_STRING_32
			-- Current last name, if any.

feature  {ESA_SUPPORT_USER_REGISTER} -- Defautl properties

	question: INTEGER
			-- Current selected question.

	answer: IMMUTABLE_STRING_32
			-- Current answer, if any.

feature -- Change Element

	set_first_name (a_first_name: READABLE_STRING_GENERAL)
			-- Set `first_name' with `a_first_name'.
		do
			create first_name.make_from_string_general (a_first_name)
		ensure
			first_name_set: attached first_name as v and then a_first_name.same_string (v)
		end

	set_last_name (a_last_name: READABLE_STRING_GENERAL)
			-- Set `last_name' with `a_last_name'.
		do
			create last_name.make_from_string_general (a_last_name)
		ensure
			last_name_set: attached last_name as v and then a_last_name.same_string (v)
		end

	set_user_name (a_user_name: READABLE_STRING_GENERAL)
			-- Set `user_name' with `a_user_name'.
		do
			create user_name.make_from_string_general (a_user_name)
		ensure
			user_name_set: attached user_name as v and then a_user_name.same_string (v)
		end

	set_email (a_email: READABLE_STRING_GENERAL)
			-- Set `email' with `a_email'.
		do
			create email.make_from_string_general (a_email)
		ensure
			email_set: attached email as v and then a_email.same_string (v)
		end

	set_password (a_password: READABLE_STRING_GENERAL)
			-- Set `password' with `a_password'.
		do
			create password.make_from_string_general (a_password)
		ensure
			password_set: attached password as v and then a_password.same_string (v)
		end

	set_check_password (a_check_password: READABLE_STRING_GENERAL)
			-- Set `check_password' with `a_check_password'.
		do
			create check_password.make_from_string_general (a_check_password)
		ensure
			check_password_set: attached check_password as v and then a_check_password.same_string (v)
		end

end

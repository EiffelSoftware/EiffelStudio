note
	description: "Object view that represent register data"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REGISTER_VIEW

feature -- Access

	questions: detachable LIST [SECURITY_QUESTION]
			-- Possible list of security questions.

	question: INTEGER
			-- Current selected question.

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

	answer: detachable READABLE_STRING_32
			-- Current answer, if any.

feature -- Status Report

	is_valid_form: BOOLEAN
			-- Are the current values valid?
			-- all fields are required.
			-- question /= 0 and should be part of the available security questions id.
			-- password and check_password should match
			-- email should be a well formed email.
		local
			l_errors: STRING_TABLE [READABLE_STRING_32]
		do
			create l_errors.make (0)
			if question = 0 then
				l_errors.put ("Not selected question", "question")
			end
			if password = Void or else (attached password as l_password and then l_password.is_empty) then
				l_errors.put ("Password is required", "password")
			end
			if check_password = Void or else (attached check_password as l_check_password and then l_check_password.is_empty) then
				l_errors.put ("Check Password is required", "check_password")
			end
			if user_name = Void or else (attached user_name as l_user_name and then l_user_name.is_empty) then
				l_errors.put ("Username is required", "user_name")
			end
			if email = Void or else (attached email as l_email and then l_email.is_empty) then
				l_errors.put ("Email is required", "email")
			end
			if answer = Void or else (attached answer as l_answer and then l_answer.is_empty) then
				l_errors.put ("Answer is required", "answer")
			end
			if first_name = Void or else (attached first_name as l_first_name and then l_first_name.is_empty) then
				l_errors.put ("First name is required", "first_name")
			end
			if last_name = Void or else (attached last_name as l_last_name and then l_last_name.is_empty) then
				l_errors.put ("Last name is required", "last_name")
			end
			if attached password as l_password and then attached check_password as l_check_password then
				if l_password.is_empty or else l_check_password.is_empty then
					l_errors.put ("Password and Check password does not match", "Check_passowrd")
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

feature -- Change Element

	set_questions (a_questions: like questions)
			-- Set `questions' with `a_questions'.
		do
			questions := a_questions
		ensure
			questions_set: questions = a_questions
		end

	set_question (a_question: like question)
			-- Set `question' with `a_question'.
		do
			question := a_question
		ensure
			question_set: question = a_question
		end

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

	set_answer (a_answer: like answer)
			-- Set `answer' with `a_answer'.
		do
			answer := a_answer
		ensure
			answer_set: answer = a_answer
		end

	add_error (a_key: READABLE_STRING_32; a_description: READABLE_STRING_32)
			-- Add an error with key `a_key' and description `a_description'
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

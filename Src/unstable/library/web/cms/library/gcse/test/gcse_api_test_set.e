note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GCSE_API_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines


feature {NONE} -- Implementation

	has_error (l_captcha: GCSE_API; a_error: READABLE_STRING_8): BOOLEAN
		do
			if attached l_captcha.errors as l_errors then
				l_errors.compare_objects
				Result := l_errors.has (a_error)
			end
		end

end



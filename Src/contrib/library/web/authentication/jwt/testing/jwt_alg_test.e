note
	description: "Summary description for {JWT_ALG_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_TEST

inherit
	JWT_ALG

feature -- Access

	name: STRING = "test"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			Result := "TEST<<"+ a_message + ">>"
		end

end

note
	description: "Summary description for {JWT_ALG_NONE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_NONE

inherit
	JWT_ALG
		redefine
			is_none
		end

feature -- Access

	name: STRING = "none"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			create Result.make_empty
		end

feature -- Status report

	is_none: BOOLEAN = True
			-- Is Current algorithm is "none" ?

end

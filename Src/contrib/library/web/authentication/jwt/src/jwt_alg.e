note
	description: "JWT signature is based on Current algorithm"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JWT_ALG

feature -- Access

	name: READABLE_STRING_8
		deferred
		end

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		deferred
		end

feature -- Status report

	is_none: BOOLEAN
			-- Is Current algorithm is "none" ?
		do
		end

end

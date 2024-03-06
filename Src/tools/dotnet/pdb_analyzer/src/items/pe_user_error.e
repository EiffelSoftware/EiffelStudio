note
	description: "Summary description for {PE_USER_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_USER_ERROR

inherit
	PE_ERROR

create
	make

feature -- Initialization

	make (m: STRING)
		do
			message := m
		end

feature -- Access

	message: READABLE_STRING_8

	to_string: READABLE_STRING_8
		do
			Result := message
		end

invariant

end

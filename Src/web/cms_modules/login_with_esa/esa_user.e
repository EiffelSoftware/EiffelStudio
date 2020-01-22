note
	description: "Summary description for {ESA_USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER

create
	make

feature {NONE} -- Creation

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	email: detachable IMMUTABLE_STRING_8

feature -- Change

	set_email (a_email: READABLE_STRING_8)
		do
			create email.make_from_string (a_email)
		end

end

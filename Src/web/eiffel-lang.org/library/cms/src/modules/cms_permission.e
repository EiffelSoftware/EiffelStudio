note
	description: "Summary description for {CMS_PERMISSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PERMISSION

create
	make

convert
	make ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8})

feature {NONE} -- Initialization

	make (n: like name)
		do
			name := n
		end

feature -- Access

	name: READABLE_STRING_8

	description: detachable READABLE_STRING_8

feature -- Change

	set_description (s: like description)
		do
			description := s
		end

end

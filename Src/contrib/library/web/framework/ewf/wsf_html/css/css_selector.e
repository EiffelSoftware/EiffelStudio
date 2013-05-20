note
	description: "Summary description for {CSS_SELECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CSS_SELECTOR

create
	make_from_string

convert
	make_from_string ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8})

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
		do
			string := s
		end

feature -- Conversion

	string: READABLE_STRING_8

end

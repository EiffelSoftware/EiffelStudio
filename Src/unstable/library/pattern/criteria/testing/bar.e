note
	description: "Summary description for {BAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAR

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature

	make (s: READABLE_STRING_GENERAL)
		do
			value := s
		end

	value: READABLE_STRING_GENERAL

	is_equal (other: like Current): BOOLEAN
		do
			Result := value.same_string (other.value)
		end

end


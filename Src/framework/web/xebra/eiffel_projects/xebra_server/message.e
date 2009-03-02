note
	description: "Summary description for {MESSAGE}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE

inherit

	STRING
		rename
			valid_code as valid_code_string
		end

	STORABLE
		undefine
			copy,
			out,
			is_equal
		end

create
	make

feature -- Access

end

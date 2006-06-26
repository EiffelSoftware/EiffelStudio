indexing
	description: "Simple string properties."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_PROPERTY [G->STRING_GENERAL]

inherit
	TEXT_PROPERTY [G]

create
	make

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value is
			-- Convert displayed data into data.
		local
			l_string: like displayed_value
		do
				-- default implementation is to just do an assignement attempt
			l_string := a_string.twin
			l_string.replace_substring_all ("%%N", "%N")
			Result ?= l_string.to_string_32
			if Result = Void then
				Result ?= l_string.to_string_8
			end
		end

end

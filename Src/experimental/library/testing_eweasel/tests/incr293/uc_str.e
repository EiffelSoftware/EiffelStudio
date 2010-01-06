indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UC_STR

inherit
	K_STR

	STR
		redefine
			append_string, infix "+"
		end

feature

	append_string (t: STR) is
		do
		end

	infix "+" (other: STR): like Current is
		do
		ensure then
			final_unicode: is_equal (Result)
		end


end

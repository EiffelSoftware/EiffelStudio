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
			append_string, plus
		end

feature

	append_string (t: STR) is
		do
			do_nothing
		end

	plus alias "+" (other: STR): like Current is
		do
		ensure then
			final_unicode: is_equal (Result)
		end


end

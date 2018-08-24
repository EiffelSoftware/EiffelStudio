note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_HELPER

feature -- Helper functions

	is_valid_name (a_string: STRING): BOOLEAN
			-- Is `a_string' a valid name?
		do
			Result :=
				attached a_string and then
				not a_string.is_empty and then
				not a_string.has (' ') and then
				not a_string.has ('+') and then
				not a_string.has ('-') and then
				not a_string.has ('*')
		end

end

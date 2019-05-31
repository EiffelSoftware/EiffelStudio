note
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

	is_valid_name_32 (s: READABLE_STRING_32): BOOLEAN
			-- Is `s' a valid name?
		do
			Result :=
				attached s and then
				not s.is_empty and then
				not s.has (' ') and then
				not s.has ('+') and then
				not s.has ('-') and then
				not s.has ('*')
		end

end

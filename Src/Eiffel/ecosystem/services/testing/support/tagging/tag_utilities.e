indexing
	description: "[
		Static class providing helper functions for tags
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_UTILITIES

feature -- Access

	valid_chars: !STRING = "._{}"
			-- Valid chars for tags other than alpha numeric

feature -- Basic functionality

	find_tags_in_string (a_string: !STRING; a_callback: !PROCEDURE [ANY, TUPLE [!STRING]]) is
			-- Extract tags defined in string.
			--
			-- `a_string': String to look for tags.
			-- `a_callback': Routine called once for every tag found in string.
		local
			l_start, l_end: INTEGER
			l_op: TUPLE [!STRING]
			l_char: CHARACTER
		do
			from
				l_start := 1
				l_end := 1
			until
				l_start > a_string.count
			loop
				l_char := a_string.item (l_end)
				l_end := l_end + 1
				if not (l_char.is_alpha_numeric or valid_chars.has (l_char)) then
					if l_end > l_start then
						l_op := [a_string.substring (l_start, l_end-1)]
						if a_callback.valid_operands (l_op) then
							a_callback.call (l_op)
						end
					end
					l_start := l_end + 1
				end
				l_end := l_end + 1
			end
		end

end

class TEST2

inherit
	TEST3

feature

	replace_substring (a_string: TEST3; start_index, end_index: INTEGER) is
		do
		ensure
			replaced: Current ~ (old (substring (1, start_index - 1) + a_string + substring (end_index + 1, 10)))
		end

	substring (start_index, end_index: INTEGER): like Current is
		do
		end

	plus alias "+" (other: TEST3): like Current is
		do
		end

end

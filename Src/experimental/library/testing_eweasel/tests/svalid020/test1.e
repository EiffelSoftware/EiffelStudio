
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

inherit
	TEST2
		redefine
			substring, plus, replace_substring
		end

feature

	replace_substring (a_string: TEST3; start_index, end_index: INTEGER) is
			-- Replace the substring from `start_index' to `end_index',
			-- inclusive, with `a_string'.
			-- (ELKS 2001 STRING)
		do
		end

	substring (start_index, end_index: INTEGER): like Current is
			-- New object containing all characters
			-- from `start_index' to `end_index' inclusive
			-- (ELKS 2001 STRING)
		do
		end

	plus alias "+" (other: TEST2): like Current is
			-- New object which is a clone of `Current' extended
			-- by the characters of `other'
			-- (ELKS 2001 STRING)
		do
		end

end

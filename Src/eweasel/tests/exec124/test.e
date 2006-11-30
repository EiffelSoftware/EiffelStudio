
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make is
		local
			s: STRING
		do
			s := "foobar"
			s.replace_substring (s, 4, 6)
			print (s); io.new_line
		end;

end

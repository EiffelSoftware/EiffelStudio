
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			l_a: A [STRING, expanded C [ANY]]
			l_b: B [expanded C [ANY]]
		do
			create l_a.make
			io.put_string (l_a.generating_type)
			io.new_line
			io.put_string (l_a.item.generating_type)
			io.new_line
			io.put_string (l_a.c.generating_type)
			io.new_line

			create l_b
			io.put_string (l_b.generating_type)
			io.new_line
			io.put_string (l_b.item.generating_type)
			io.new_line
		end
	
end

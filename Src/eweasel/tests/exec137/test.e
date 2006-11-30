
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
			a, b: ARRAY [X]
			x1, x2: X
		do
			create a.make (1, 2)
			create b.make (1, 2)
			a.put (x1, 1)
			b.put (x2, 1)
			print (deep_equal (a, b)); io.new_line
		end
end


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
			p: TEST1
		do
			x := [1, p]
			io.put_string (x.generator)
			io.new_line
			io.put_string (x.generating_type)
			io.new_line
  		end
			
	x: TUPLE

end

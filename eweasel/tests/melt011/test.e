
--| Copyright (c) 1993-2017 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make	
feature	

	make is
		local
			x: ARRAY [REAL_64]
		do
			x := {ARRAY [REAL_64]} << 1, 2, 3 >>
			io.put_double (x [1])
			io.put_new_line
		end

end


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
			r: REAL
		do
			$INST
			r := {REAL_32} 50.0
			r := c_floor (r)
			io.put_real (r)
			io.new_line
		end

	c_floor (r: REAL): REAL is
			-- Greatest integral value no greater than `r'
		external
			"C signature (double): EIF_REAL use <math.h>"
		alias
			"floor"
		end


end
    


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature
	make is
		do
			$INSTRUCTION
			print (my_arc_tangent ({REAL_32} 0.5)); io.new_line
		end

	x: INTEGER

	my_arc_tangent (v: REAL): DOUBLE is
		external
			"C signature (double): EIF_DOUBLE use <math.h>"
		alias
			"atan"
		end

end

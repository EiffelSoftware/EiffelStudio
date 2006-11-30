
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [I -> INTEGER, R -> REAL, D -> DOUBLE]
			
feature
	int_to_int (x: I): I is
		do
			print (x.out); io.new_line
			Result := x
		end
	
	real_to_real (x: R): R is
		do
			print (x.out); io.new_line
			Result := x
		end
	
	double_to_double (x: D): D is
		do
			print (x.out); io.new_line
			Result := x
		end
	
end


--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	make
		do
			io.putbool (k = m); io.new_line;
			io.putbool (equal (k, m)); io.new_line ;
			create x1.make ;
			create x2.make ;
			create x3.make ;
			create x4.make ;
			create x5.make ;
			create x6.make ;
			create x7.make ;
			create x8.make ;
			create x9.make ;
			create x10.make;
		end
	
	k, m: INTEGER;
	
	x1: TEST1 [INTEGER];
	x2: TEST1 [REAL];
	x3: TEST1 [DOUBLE];
	x4: TEST1 [BOOLEAN];
	x5: TEST1 [CHARACTER];
	x6: TEST1 [POINTER];
	x7: TEST1 [STRING];
	x8: TEST1 [TEST];
	x9: TEST1 [TEST1 [DOUBLE]];
	x10: TEST1 [TEST2];
end

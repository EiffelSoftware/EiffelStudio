
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		do
			io.putbool (k = m); io.new_line;
			io.putbool (equal (k, m)); io.new_line;
			!!x1.make;
			!!x2.make;
			!!x3.make;
			!!x4.make;
			!!x5.make;
			!!x6.make;
			!!x7.make;
			!!x8.make;
			!!x9.make;
			!!x10.make;
			!!x11.make;
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
	x11: TEST1 [BIT 100];
end

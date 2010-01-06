
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is (without freezing).  Execute `test'.
	-- Run-time panic occurs indicating "illegal cast operation".

class TEST
creation
	make
feature
	
	make is
		local
			d: DOUBLE;
			r: REAL;
		do
			io.putstring ("Starting creation proc%N");
			d := r + 0.1;
			io.putstring ("Point 1%N");
			d := 1.0 + r;
			io.putstring ("Point 2%N");
			d := 1.0 + 0.1;
			io.putstring ("Point 3%N");
			io.putstring ("End of creation proc%N");
		end;

end


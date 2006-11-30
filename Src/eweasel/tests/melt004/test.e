
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is (without freezing).
	-- Execute `test'.  Exception trace before body of `try' is executed.

class TEST
creation
	make
feature
	make is
		local
			x: TEST1;
			y: expanded TEST1
		do
			!!x;
			io.putstring ("Calling try%N");
			y.make (x)
			try (y);
		end;

	try (arg1: expanded TEST1) is
		do
			io.putstring ("In try%N");
		end;
end


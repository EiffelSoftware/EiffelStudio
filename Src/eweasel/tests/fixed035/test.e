
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Behaves correctly.
	-- Uncomment first line in body of `make'.  Rerun es3.
	--	Execute `test'.  Incorrect output.

class 
	TEST
creation	
	make
feature
	
	make is 
		do
			io.putstring ("Before conditional%N");
			if true then
			else
				io.putstring ("How did we get here?%N");
			end;
			io.putstring ("After conditional%N");
		end;

end

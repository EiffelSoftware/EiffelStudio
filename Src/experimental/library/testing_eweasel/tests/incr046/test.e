
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is (no creation proc in Ace).  Execute `test'.  
	--	No output, which is correct.
	-- Uncomment the `expanded' in header of TEST1.  Recompile.
	--	Execute `test'.  Still no output, which is wrong.
	-- Compile from scratch.  Execute `test'.  Now creation
	--	procedure of TEST1 is executed.

class TEST
feature
	x: TEST1;
end


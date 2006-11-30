
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.
	-- Then make `x' in the class be of type `expanded TEST1'.
	-- Recompile.  VTEC violation is detected.
	-- Delete clause `creation make' from TEST1.  Resume compilation.
	--	Compiler still reports VTEC violation, though there is none.

class 
	TEST
	
creation
	make
feature

	make is
		do
		end;

	x: TEST1;
end


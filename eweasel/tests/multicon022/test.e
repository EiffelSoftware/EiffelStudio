
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Then comment out class header in TEST2 and uncomment the
	--	new header line below it (with a generic constraint).
	-- Recompile.  Compiler exception trace (should report VTGG violation).

class 
	TEST
creation
	make
feature
	make is
		do
		end;

	x: TEST1 [INTEGER]
end


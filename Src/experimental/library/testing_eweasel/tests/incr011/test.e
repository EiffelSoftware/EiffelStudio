
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Then delete declaration for feature `z'.  Recompile.
	--	Compiler reports VEEN violation.  Press return.
	--	Compilation proceeds and finishes, although the VEEN
	--	violation is still present.

class 
	TEST
creation
	make
feature
	make is
		do
			!!z;
		end;

	z: TEST1;
end


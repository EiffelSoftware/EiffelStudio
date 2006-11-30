
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Remove parentheses from invariant to yield: `not 3 = 5'.
	-- Recompile.  When compiler reports VWOE error, delete the entire 
	--	invariant.
	-- Resume.  Compiler exception trace.

class TEST
creation
	make
feature
	make is
		do
		end;
		
invariant
	not (3 = 5);

end


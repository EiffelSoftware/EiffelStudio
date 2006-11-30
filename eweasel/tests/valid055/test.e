
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Compiler reports VTUG3 instead of VTUG as "main" error.

class TEST
		
creation
	make
feature
	
	make is
		local
			x: TEST1 [INTEGER, STRING, REAL];
		do
		end;

end 

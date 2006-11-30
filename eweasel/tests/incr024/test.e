
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Remove last formal generic parameter I from TEST1.
	--	Rerun es3.  VTUG violation correctly detected.
	-- Hit return with no change to either class.
	-- Compiler exception trace.

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


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler reports VGCC2, but 
	--	INTEGER is an effective class so there is no VGCC2 violation.

class TEST 
creation
	make
feature
	
	make is
		do
			!INTEGER!x;
		end;
	
	x: TEST1;
end


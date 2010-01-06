
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

-- To reproduce error:
-- Compile classes as is.  Compiler reports VJAR violation.  Change class
--	TEST1 so that it is no longer expanded (remove keyword `expanded').
--	System now compiles fine.

class TEST
creation
	make
feature
	make is
		local
			x: TEST1 [PARENT];
			y: TEST1 [CHILD];
		do
			x := y;
		end;

end

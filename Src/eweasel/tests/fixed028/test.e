
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  When VJAR violation is reported,
	-- comment out the declarations of locals `x' and `y' in
	-- feature `make' of this class.  Save and hit return.
	-- Es3 dies with exception trace.
class 
	TEST
inherit
		TEST1 [STRING];
creation
	make
feature
	
	make is
		local
			$LOCALS
		do
		end;
	
end


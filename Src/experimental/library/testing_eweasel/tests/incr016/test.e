
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is, with class WEASEL in file test1.e.  
	-- Compiler detects VTCT violation.  
	-- Change name of class WEASEL (leaving it in the same file) to TEST1.
	-- Resume.  Class TEST1 is now present, but compiler still reports
	--	VTCT for it.

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


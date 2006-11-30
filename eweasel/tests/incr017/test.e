
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Then change the names of classes: 
	--	In file test1.e  `class TEST2'
	--	In file test2.e  `class TEST1'
	-- (i.e., switch the names of classes in files test1.e and test2.e).
	-- Recompile.  Compiler reports VSCN, but there is no VSCN violation.

class 
	TEST
creation
	make
feature
	make is
		do
		end;

	x: TEST1;
	y: TEST2;
end


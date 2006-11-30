
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then change name of class in file `test1.e' to TEST.  Recompile.
	-- Compiler detects VSCN violation.  Hit return to resume
	--	compilation.  Compiler continues instead of reporting 
	--	the VSCN violation again.

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

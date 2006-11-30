
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then change header of class TEST1 to make it an expanded class.
	-- Recompile.  Compiler does not detect VGCC(3) error.

class TEST
creation
	make
feature

	make is
		do
			!TEST1!x;
		end;
		
	x: TEST1;
end

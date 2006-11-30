
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Change type of `x' to DOUBLE and value to 13.1.
	-- Recompile.  VOMB violation not detected.

class 
	TEST
creation
	make
feature
	make is
		do
			inspect
				3
			when x then
				io.putstring("Ooh%N");
			end
		end;
	
	x: DOUBLE is 13.1;
end

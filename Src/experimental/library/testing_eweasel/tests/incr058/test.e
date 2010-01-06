
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Change value of `b' to 3.
	-- Recompile.  VOMB violation not detected.

class TEST
creation
	make
feature

	make is
		do
			inspect
				5
			when a, b  then
			end
		end;

	a: INTEGER is unique;
	
	b: INTEGER is $VALUE;
end

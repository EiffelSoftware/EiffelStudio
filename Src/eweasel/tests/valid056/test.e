
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
	
	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it, even though
	--	`$x' is of type POINTER, which does not conform to TEST
	--	(at least, I think it doesn't).
	
class TEST 
creation
	make
feature
	
	make is
		local
		do
			x := $x;
		end;
	
	x: TEST;
	
end


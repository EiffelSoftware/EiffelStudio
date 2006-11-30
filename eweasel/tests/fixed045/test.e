
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 dies with exception trace.
	-- (You can uncomment other lines below individually).
class 
	TEST

creation	
	make
feature
	
	make is 
		local
			b1, b2: BOOLEAN
		do
			b1 := true or false;
			b1 := true and false;
			b1 := true or else false;
			b1 := true and then false;
			b1 := true xor false;
			b1 := true implies false;
			b1 := not true;
		end;

end

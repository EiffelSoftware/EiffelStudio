
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 accepts it without complaint even
	-- though it appears to violate VZAA.


class 
	TEST
creation	
	make
feature
	
	make (s: ARRAY [STRING]) is
		local
			x: REAL;
		do
			$BODY
		end;
		
	try (p: ANY) is
		do
		end;

	infix "or" (n: TEST): TEST is
		do
		end;

	b: STRING is "abc";
	
	c: INTEGER is 3;
	
end

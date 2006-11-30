
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	
creation
	make
feature
	-- To reproduce error:
	-- Compile with class as is.
	-- Then uncomment declaration of feature `x' and comment out
	-- declaration of feature `a' (i.e. change name of `a' to `x').
	-- Then run es3 again.
	
	make is
		do
		end;
	
	$FEATURE

	b: INTEGER is
		local
			x: INTEGER;
		do 
			x := c * c;
			Result := x;
		end;

	c: INTEGER;
end 

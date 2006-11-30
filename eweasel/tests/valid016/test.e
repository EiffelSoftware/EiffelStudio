
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.

class 
	TEST
creation	
	make
feature
	
	make is 
		do
		end;

	try (x: INTEGER): INTEGER is
		require else
			good: x > 0
		do
			Result := x * x;
		ensure then
			good: Result > 0
		end
end

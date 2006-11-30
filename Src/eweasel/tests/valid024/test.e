
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it even though
	--	equivalent dot form of `next # 3' is
	--	`next.pound (3)', which is not export valid.
	--	(To verify this, uncomment out both commented lines in body
	--	of `make' and run es3).

class 
	TEST
creation
	make
feature
	
	make is
		do
			io.putint (pound (3));
			-- io.putint (Current.pound (3));
			-- io.putint (next.pound (3));
			io.putint (Current # 3);
			io.putint (next # 3);
		end;

feature {NONE}
	
	pound, infix "#" (n: INTEGER): INTEGER is
		do
			Result := 47;
		end;

	next: TEST;
end


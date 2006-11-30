
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

	-- 1. Compile as is.
	-- 2. Uncomment unique1 and unique2 declarations below, save and
	--    hit return to retry compilation.
	-- 3. Comment out unique1 and unique2 declarations below and uncomment
	--    inheritance clause, save and hit return to retry compilation.
	
-- inherit
	-- TEST1;
	-- TEST2;
creation 
	make

feature
	make is 
		local
			x: INTEGER;
		do
			x := 3;
			inspect x
			when unique1 then
				io.putstring ("One");
			when unique1 then
				io.putstring ("Two");
			end;
		end;

	-- unique1, unique2: INTEGER is unique;
end 

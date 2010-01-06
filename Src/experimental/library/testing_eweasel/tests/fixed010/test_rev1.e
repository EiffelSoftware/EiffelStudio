
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

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

	unique1, unique2: INTEGER is unique;
end 

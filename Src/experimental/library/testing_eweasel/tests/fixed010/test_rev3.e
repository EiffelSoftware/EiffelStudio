
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	TEST1;
	TEST2;
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
			when unique2 then
				io.putstring ("Two");
			end;
		end;

end 

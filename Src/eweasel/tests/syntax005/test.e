
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
			x := 5;
			inspect
				x
			-- when 13..5 then
			when then
				io.putstring ("Error%N");
			else
				io.putstring ("OK%N");
			end
		end;

end 

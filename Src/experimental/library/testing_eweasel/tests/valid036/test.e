
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 reports violation of VOMB even
	-- though class appears to be valid.

class 
	TEST
creation	
	make
feature
	
	make is
		do
			inspect
				2
			when 5..3, 5..3, 5..3  then
				io.putstring ("Oh no%N");
			else
				io.putstring ("OK%N");
			end
		end;
		
end

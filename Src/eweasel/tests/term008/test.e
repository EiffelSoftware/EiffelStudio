
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 dies with exception trace while
	--	freezing system.

class 
	TEST
creation	
	make
feature
	
	make is
		local
		do
			io.putstring ("Hi%N");
			from
			variant Void
			until true
			loop
				io.putstring ("Hey%N");
			end
		end;
		
end

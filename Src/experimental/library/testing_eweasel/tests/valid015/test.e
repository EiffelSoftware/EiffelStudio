
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Es3 accepts NONE as formal generic
	-- parameter in TEST1.

class 
	TEST

inherit
	TEST1 [STRING];
creation
	make
feature
	
	make is
		do
			f ("abc");
		end;
	
end


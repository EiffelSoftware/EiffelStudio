
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile classes as is.


creation
	make
feature
	
	make is
		do
		end;

	f: TEST1 [TEST1 [STRING, REAL, INTEGER], TEST1 [STRING, REAL, INTEGER],
		TEST1 [STRING, REAL]] is
		do
		end;
end 

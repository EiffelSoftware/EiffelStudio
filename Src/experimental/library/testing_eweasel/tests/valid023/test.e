
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler accepts them, even though
	--	TEST1 has a generic constraint with an invalid Class_type.

class 
	TEST
creation
	make
feature
	
	make is
		local
			x: TEST1 [ARRAY[INTEGER]];
		do
		end;
	
end

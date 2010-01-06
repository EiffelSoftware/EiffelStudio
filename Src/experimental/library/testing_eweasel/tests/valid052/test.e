
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  Compiler reports VTGG violation.
	--	Switch order of formal generic parameters in TEST1.
	--	Now compiler reports VTCT.  
	-- It seems that G should represent the same thing anywhere
	--	in the Formal_generic part: either class or formal generic.

class 
	TEST
creation
	make
feature

	make is
		do
		end;

	x: TEST1 [STRING, STRING];
end


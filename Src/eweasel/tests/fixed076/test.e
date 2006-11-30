
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler correctly reports VSRC violation.
	-- Remove `[G]', making class non-generic.  Hit return. 
	--	Compiler dies with exception trace.

class 
	TEST $GENERICS
creation
	make
feature
	
	make is
		do
			io.putstring("Hey you weasel%N");
		end;
	
end

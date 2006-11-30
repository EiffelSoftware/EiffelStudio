
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the error:
	-- Compile with classes as is.  Es3 reports violation of VE04,
	--	although the classes seem to be valid (I'm not sure).
	-- Hit return to retry compilation without changing anything.
	-- Compiler dies with exception trace.
class 
	TEST
inherit
	TEST1 [like Current];
creation
	make
feature
	
	make is
		do
		end;

end

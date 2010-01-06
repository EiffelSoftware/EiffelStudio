
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports violation of
	-- VRLE instead of VEEN.
class 
	TEST
creation	
	make
feature
	
	make is
		do
		end;
	
	f is
		do
			!!Result;
			-- !!weasel;
		end
end

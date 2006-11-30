
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Change declaration of `b' in TEST to `b: INTEGER is 1'.
	-- Recompile.  When compiler reports VWBE violation,
	--	delete declaration of `b' from TEST and uncomment
	--	declaration of `b' in TEST1.
	-- Resume.  Compiler does not detect VWBE violation.


class 
	TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
			if b then
			end
		end;

end


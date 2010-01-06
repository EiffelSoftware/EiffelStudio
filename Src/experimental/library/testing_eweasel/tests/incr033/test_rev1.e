
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Move declaration of `b' to TEST1 and make it an external BOOLEAN
	--	function.  Recompile.
	-- Change return type of function `b' in TEST1 to REAL.  Recompile.
	-- When compiler reports VWBE violation, move function `b' to
	--	TEST and change its return type back to BOOLEAN.
	-- Resume.  Compiler exception trace.


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


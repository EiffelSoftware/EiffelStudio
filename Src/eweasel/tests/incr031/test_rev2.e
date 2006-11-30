
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:   (sorry this is so long)
	-- Compile classes as is.
	-- Change declaration of `b' in TEST to `b: BOOLEAN is true'.
	-- 	Recompile.
	-- Change value of b to 1 (leave as BOOLEAN).  Recompile.
	-- When compiler reports VQMC, change type of b to INTEGER.  Resume.
	-- When compiler reports VWBE, delete b from TEST and uncomment
	--	declaration of b in TEST1.  Resume.
	-- When compiler reports VWBE, delete b from TEST1 and put in TEST
	--	as a BOOLEAN external function.  Resume.
	-- Compiler exception trace.


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

	b: BOOLEAN is 1;
end


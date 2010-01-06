
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  When compiler reports VLEC violation,
	--  	replace declaration of `x' in TEST1 with commented out
	--	version below existing one.  Resume.  Compiler still
	--	reports VLEC, although classes are valid.

class TEST
inherit
	TEST1 [TEST]

creation
	make
feature
	make is
		do
		end;
end


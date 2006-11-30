
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.
	-- Then comment out rename `m as n' in TEST1.  Recompile.
	-- 	VRFA violation is detected.  
	-- Now add the rename back to TEST1.  Resume.  Compiler reports
	--	bogus VD27 error.

class TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
		end;

	try (m: REAL) is
		do
		end;

end





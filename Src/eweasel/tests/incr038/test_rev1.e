
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Change name of `x' in TEST1 to `y'.  Recompile.
	-- When compiler reports VHRC violation, delete attribute `y'
	--	from TEST1 and also delete the rename clause in
	--	TEST.  Resume.  Compiler exception trace.

class 
	TEST
inherit
	TEST1 [DOUBLE]
creation
	make
feature

	make is
		do
		end;

end


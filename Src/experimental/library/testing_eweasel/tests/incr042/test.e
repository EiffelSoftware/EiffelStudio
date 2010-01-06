
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- When compiler reports VEEN error, comment out the single
	--	assertion in the class invariant.  Resume.  Compiles OK.
	-- Now uncomment the invariant assertion. Recompile.  Exception trace.

class TEST
creation
	make
feature
	make is
		do
		end;
		
invariant
	n = 0;
end



--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- When compilation finishes, uncomment the 6 commented out lines
	--	and comment out the 5 lines below them, which changes
	--	the routine from an external to internal one.
	-- Recompile.  When compiler reports VREG violation, change
	--	2nd and 3rd occurences of `x1' to `x2' and `x3', respectively.
	-- Save and hit return.  Compiler dies with exception trace.

class TEST
creation
	make
feature
	make is
		$BODY

end




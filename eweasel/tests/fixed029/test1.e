
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compiler stops and reports VWBE violation, comment
	-- out the `inherit TEST;' below, save and hit return to
	-- retry compilation.  Compiler skips some passes on TEST
	-- and TEST1, then dies when it's ready to freeze system.

class 
	TEST1
$INHERITANCE
end

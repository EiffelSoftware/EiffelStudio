
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  When compiler reports VD27 error,
	--	remove `: "make"' from Ace (creation proc name),
	--	save and hit return to retry.  Compiler still reports
	--	VD27, even though there is now no error.

class 
	TEST
feature
	
	x: expanded TEST1;
end

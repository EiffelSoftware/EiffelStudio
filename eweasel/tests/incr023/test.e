
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Change TEST1 to a deferred class by uncommenting both
	-- occurrences of "deferred" and commenting out "do" in body
	-- of `a'.
	-- Rerun es3. When compiler reports VTEC violation, change TEST1
	--	back to its original state (deferred class with one
	--	deferred feature).  
	-- Resume compilation.  Exception trace.

class TEST

creation
	make
feature
	
	a: expanded TEST1;

	make is
		do
		end;
	
end 


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Make sure you specify `assertion (ensure)' in Ace.
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Works correctly.
	-- Comment out first line of `make'.
	--	Rerun es3.  Execute `test'.  Get run-time panic.

class 
	TEST
creation
	make
feature
	
	make is
		do
		ensure
			post1: check_it (<< 1, old 2, 3 >>);
		end;
	
	check_it (arg: ARRAY [ANY]): BOOLEAN is
		do
			Result := true;
		end
end

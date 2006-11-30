
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Comment out inheritance clause for TEST1 in TEST.
	-- Recompile.  VUEX violation not detected.

class 
	TEST
inherit
	TEST1
creation
	make
feature
	make is
		do
			a.x;
		end;
	
	a: TEST1;
end


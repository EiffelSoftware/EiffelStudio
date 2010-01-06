
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.
	-- Then change name of attribute in TEST1 from `Test_me' to
	--	`Dont_test_me'.  Recompile.  VEEN violation not detected.

class TEST 
inherit
	TEST1
creation
	make
feature
	make is
		do
			io.putstring (Test_me); io.new_line;
		end;
end 

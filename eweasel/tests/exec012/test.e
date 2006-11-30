
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is (with freezing) and with `assertion (require).
	-- Finish_freezing.  Execute `test'.  Gets precondition violation,
	--	but should not since precondition is:
	--	(implicit) true or else false
	-- If the true precondition is made explicit in TEST1, it works
	--	correctly.

class 
	TEST
inherit
	TEST1
		redefine
			feat
		end
creation
	make
feature

	make is
		do
			feat;
		end;

	feat is
		require else
			impossible: false
		do
			io.putstring ("In redefined feat%N");
		end;
end


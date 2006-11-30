
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is (freeze).  Finish_freezing. 
	-- 	Execute `test'.  Correct output.
	-- Change type of formal argument of routine `weasel' to
	--	`expanded TEST1'.  Recompile (melt).  Execute `test'.
	--	Dies with illegal instruction instead of 
	--	"void assigned to expanded" exception.

class TEST
creation
	make
feature
	make is 
		do 
			io.putstring ("Starting make%N");
			weasel (x);
		end

	x: TEST1;
	
	weasel (n: $EXPANDED TEST1) is
		do
			io.putstring ("In weasel%N");
		end
end

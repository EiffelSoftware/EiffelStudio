
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the problem:
	-- Compile class as is with Ace supplied.  Finish_freezing.  
	-- Execute `test'.  Correct debug instructions are executed.
	-- Change the default section of the Ace to `debug ("2")'.
	-- Rerun es3.  Execute `test`.  Debug instructions for key "1"
	--	are still executed.
class 
	TEST
creation
	make
feature
	
	make is
		do
			debug
				io.putstring ("Debug with no key%N");
			end;
			debug ("1")
				io.putstring ("In debug instruction 1%N");
			end;
			debug ("1", "2")
				io.putstring ("In debug instruction 1 and 2%N");
			end;
			debug ("2", "1")
				io.putstring ("In debug instruction 2 and 1%N");
			end;
			debug ("2")
				io.putstring ("In debug instruction 2%N");
			end;
		end;

end

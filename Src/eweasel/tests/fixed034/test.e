
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Behaves correctly.
	-- Uncomment first line in body of `make'.  Rerun es3.
	--	Fails with exception trace indicating "unmatched inspect
	--	value", but it should not.
class 
	TEST
creation	
	make
feature
	
	make is 
		local
			x: INTEGER;
		do
			io.putstring ("Before multi_branch%N");
			x := 2;
			inspect
				x
			when 1..5 then
				io.putstring ("Matched%N");
			end;
			io.putstring ("After multi_branch%N");
		end;

end


--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Finish_freezing.  Execute `test'.
	--	Output is correct.
	-- Delete the two lines from body of `make'.  Rerun es3.
	--	Only does pass 1 on class TEST.  Execute `test'.
	--	Same output as before, but no instructions in body.
	-- Rerun es3 with no further change to either class.
	-- Dies with exception trace.

class 
	TEST
create	
	make
feature
	
	make 
		do 
			create {TEST1} a;
			io.putstring ("Hey you weasel%N");
		end;

	a: TEST;
	
end

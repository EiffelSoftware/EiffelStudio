
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Dies with "Unmatched inspect value" exception even
	--	though there is an Else_part.

class 
	TEST
creation	
	make
feature
	
	make is 
		do
			io.putstring ("Before multi_branch%N");
			inspect
				1
			when 2 then
			else
				-- io.putstring ("No inspect value matched%N");
			end;
			io.putstring ("After multi_branch%N");
		end;

end

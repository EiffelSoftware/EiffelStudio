
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  No complaints, even though Ace file
	--	does not specify a creation procedure and there are
	-- 	two possibilities.

class 
	TEST
$CREATION
feature
	
	make1 (s: ARRAY [STRING]) is
		do
			io.putstring("Hey you turkey%N");
		end;
	
	make2 is
		do
			io.putstring("Hey you weasel%N");
		end;
	
end

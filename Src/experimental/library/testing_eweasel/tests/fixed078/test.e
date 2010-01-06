
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is, with Ace specifying `debug ("weasel")'.  
	--	Finish_freezing.  Execute `test'.
	--	Does not execute compound in debug instruction with
	--	debug key "WEASEL".

class TEST
creation
	make
feature

	make is
		do
			
			io.putstring ("You wimp!%N");
			debug ("WEASEL")
				io.putstring ("You weasel!%N");
			end;
			debug ("WEaSEL")
				io.putstring ("You double weasel!%N");
			end;
		end;
			
end


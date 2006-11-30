
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
	
	-- To reproduce the problem:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
class 
	TEST
creation
	make
feature
	
	make is
		do
			debug
				io.putstring ("Start: debug with no key%N");
			end;
			debug ("1", "2")
				io.putstring ("In debug instruction 1%N");
			end;
			debug ("2")
				io.putstring ("In debug instruction 2%N");
			end;
			debug
				io.putstring ("End: debug with no key%N");
			end;
		end;

end

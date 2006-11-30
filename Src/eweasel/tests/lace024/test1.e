
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
creation
	make
feature
	make is
		do
			test1_try;
			!!x;
			x.test2_try;
		end

	x: TEST2;
	
	test1_try is
		do
			io.putstring ("Entering test1_try%N");
			debug ("weasel")
				io.putstring ("TEST1 weasel%N");
			end
			debug ("wimp")
				io.putstring ("TEST1 wimp%N");
			end
		end

end

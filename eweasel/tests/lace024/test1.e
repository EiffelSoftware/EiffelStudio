
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	make
feature
	make
		do
			test1_try ;
			create x;
			x.test2_try;
		end

	x: TEST2;
	
	test1_try
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

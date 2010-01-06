
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	weasel is
		local
			x: TEST3
		do
			io.put_string ("In weasel%N");
			wimp;
			x.shark;
		end

	wimp is
		do
			io.put_string("In wimp%N");
		end
end

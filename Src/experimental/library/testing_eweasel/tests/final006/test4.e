
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST4 [G]

feature	
	weasel: G;

	wimp is
		do
			io.putstring ("In wimp%N");
		end
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
		redefine
			w
		end

feature	

	w: TEST4 is
		do
		end

end

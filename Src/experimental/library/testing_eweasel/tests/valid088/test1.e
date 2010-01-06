
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
creation
	make
feature {NONE}

	make is
		require
			positive_n: n > 0
		do
		end
	
	n: INTEGER;
	
end

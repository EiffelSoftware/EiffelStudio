
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G, H -> TEST4]
creation
	make
feature
	make is
		do
			!!b;
		end

	b: TEST3 [H, LIST [G]];
	
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

indexing
	test: abc, 0011B
class TEST
creation
	make
feature
	make is
		do
		end

	x: BIT 5 is 1111B;
	y: BIT 5 is 1111b;
end 

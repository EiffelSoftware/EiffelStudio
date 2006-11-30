
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G, H]
creation
	make
feature
	list1: ARRAY [G];

	list2: ARRAY [H];

	make is
		do
		end
	
	set (a: ARRAY [G]; b: ARRAY [H]) is
		do
			list1 := a;
			list2 := b;
		end
end

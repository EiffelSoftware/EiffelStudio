
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST3
inherit
	TEST2
convert
	to_test1: {TEST1}
feature
	x1, x2, x3, x4, x5: DOUBLE;

	to_test1: TEST1 is
		do
		end
end

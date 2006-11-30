
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2
inherit
	TEST1
convert
	test2_to_test1: {TEST1}
feature
	weasel: DOUBLE;
	
	test2_to_test1: TEST1 is
		do
		end
end

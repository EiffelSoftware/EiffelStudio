
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
feature

	test_me is
		do
			io.putstring ("Starting test_me%N");
			io.putstring (ttt.generator); io.new_line;
		end
end

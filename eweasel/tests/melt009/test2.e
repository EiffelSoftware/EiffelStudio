
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
feature

	test_me
		do
			io.putstring ("Starting test_me%N");
			io.putstring (ttt.generator); io.new_line;
		end
end

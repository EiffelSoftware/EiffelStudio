
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		local
			l_target: TEST2[STRING]
		do
			create test1
			l_target := test1.new_result
		end;

	test1: TEST1 [INTEGER, STRING]

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST 
feature
	n: INTEGER;
	
	test_me is
		do
		ensure
			(old (old n)) > 0
		end;
end 


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
			x, y: TEST;
		do
			print (y);
			print (x);
		ensure
			good_result: $SYNTAX_ERROR old (old Result)
		end

end

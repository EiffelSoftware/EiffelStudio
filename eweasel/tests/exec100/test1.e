
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> DOUBLE]
feature
	weasel (arg1: G) is
		local
			a: DOUBLE;
		do
			a := arg1;
			print (a); io.new_line;
		end
	
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

creation
	make
feature
	
	make is
		do
			!!a;
		end
	
	try is
		require
			precondition: a.b
		do
		end

	a: TEST2;
end

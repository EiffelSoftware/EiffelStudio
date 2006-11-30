
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2 create $GENERIC_CREATORS end]
	
feature
	try is
		do
			create x1.make1
			create x2.make2
		end

	x1: G
	x2: G

end

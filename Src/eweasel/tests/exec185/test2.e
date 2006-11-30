
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2
feature

	x, y, z: TEST3

	to_any: TEST2_REF is
		do
			create Result
		end
end

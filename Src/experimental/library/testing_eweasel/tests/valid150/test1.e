
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	TEST2
		redefine
			value
		end
feature
	frozen value: INTEGER is
		external "C inline"
		alias "47"
		end

end

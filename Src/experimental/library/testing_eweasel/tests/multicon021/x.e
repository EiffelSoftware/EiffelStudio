--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class X

inherit
		STRING
			undefine
				is_equal, copy, out
			end
		TEST2[X]
			undefine
				is_equal, copy, out
			end
		TEST1[X]

create {X}
	make

end

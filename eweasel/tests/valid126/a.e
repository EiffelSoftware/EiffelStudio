
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A

feature

	new_b: B [like Current] is
		do
			!! Result
		end

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	make is
		local
			b: B
		do
			f (a, b)
		end

	f (b1, b2: B) is
		do
		end

	a: A

end

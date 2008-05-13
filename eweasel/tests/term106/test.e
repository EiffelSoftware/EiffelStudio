
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
			a: A
			x1: X [A]
			x2: X [A]
		do
			!! x1
			!! x2
			!! a
			a.f (<<x1, x2>>)
			a.g ([x1, x2])
		end

end


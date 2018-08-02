
--| Copyright (c) 1993-2018 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create

	make

feature

	make
		local
			a: A
			x1: X [A]
			x2: X [A]
		do
			create x1
			create x2
			create a
			a.f (<<x1, x2>>)
			a.g ([x1, x2])
		end

end


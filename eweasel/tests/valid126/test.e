
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create

	make

feature

	make
		local
			a: A1
		do 
			create a 
			create c
			c.f (a)
		end

	c: C [A]
end

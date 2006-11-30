
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
			n: INTEGER
		do
			n := Upper_limit
			inspect n
			when 0..Upper_limit then
			end
		end

	Upper_limit: INTEGER is 2000000000
end

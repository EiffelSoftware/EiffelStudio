
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			res, loc: INTEGER
		do
			res := 63249
			loc := -10630259
			if (res < feature {INTEGER}.Min_value - loc) then
				print ("Not ok%N")
			else
				print ("Ok%N")
			end
		end
end

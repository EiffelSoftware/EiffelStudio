
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G -> NUMERIC]

feature
	value: G is
		do
			Result := x + x
		end

	set_x (val: G) is
		do
			x := val
		end

	x: G
end

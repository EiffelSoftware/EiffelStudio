
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
convert
	to_expanded: {expanded TEST1}

feature
	wimp: INTEGER;
	wuss: DOUBLE

	to_reference: TEST1 is
		do
			create Result
			set_wimp (wimp)
			set_wuss (wuss)
		end

	to_expanded: expanded TEST1 is
		do
			create Result
			set_wimp (wimp)
			set_wuss (wuss)
		end

	set_wimp (v: INTEGER) is
		do
			wimp := v
		end

	set_wuss (v: DOUBLE) is
		do
			wuss := v
		end
end

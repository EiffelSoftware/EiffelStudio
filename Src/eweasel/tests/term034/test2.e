
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2 [G]
creation
	default_create
convert
	to_reference: {ANY}
feature
	
	to_reference: ANY is
		do
		end

	x: TEST1 [TEST2 [G]]
end

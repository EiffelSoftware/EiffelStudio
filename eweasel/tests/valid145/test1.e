
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	default_create,
	make_from_reference

feature
	make_from_reference (t: TEST1) is
		do
		end

	to_reference: TEST1 is
		do
			create Result
		end
end

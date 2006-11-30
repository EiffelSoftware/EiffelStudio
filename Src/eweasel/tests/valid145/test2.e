
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
		redefine
			to_reference,
			make_from_reference
		end

create
	default_create,
	make_from_reference

feature
	make_from_reference (t: TEST2) is
		do
		end

	a, b, c: DOUBLE

	to_reference: TEST2 is
		do
			create Result
		end
end

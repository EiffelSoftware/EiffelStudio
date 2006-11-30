
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1
convert
	to_reference: {TEST1_REF}
feature
	to_reference: TEST1_REF is
		do
			create Result
			Result.set_a (a)
		end
	set_a (v: DOUBLE) is
		do
			a := v;
		end

	a, b, c, d, e: DOUBLE;
	s: STRING;
end


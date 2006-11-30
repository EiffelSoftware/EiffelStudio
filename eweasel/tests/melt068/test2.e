
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2
convert
	to_reference: {TEST2_REF}

feature
	set_a (n: DOUBLE) is
		do
			a := n
		end

	a: DOUBLE

	to_reference: TEST2_REF is
		do
			create Result
			Result.set_a (a)
		end
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
feature
	frozen value (n: G): G is
		external "C inline"
		alias "$n"
		end

	value2: G

	set_value2 (n: G) is
		do
			value2 := n
		end

	try is
		do
			print (feature {TEST1 [G]}.value (value2));
			io.new_line
		end
end

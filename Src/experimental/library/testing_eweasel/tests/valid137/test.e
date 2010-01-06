
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
		do
			w := -128
			w := w.min_value
			x := -32768
			x := x.min_value
			y := -2147483648
			y := x.min_value
			z := -9223372036854775808
			z := x.min_value
		end

	w: INTEGER_8
	x: INTEGER_16
	y: INTEGER
	z: INTEGER_64

end

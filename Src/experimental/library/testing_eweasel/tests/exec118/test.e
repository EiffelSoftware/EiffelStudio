
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			x: INTEGER_8
			y: INTEGER_16
		do
			x := (-128).to_integer_8
			print (x)
			io.new_line
			y := (-32768).to_integer_16
			print (y)
			io.new_line
		end;

end

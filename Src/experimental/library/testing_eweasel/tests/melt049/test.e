
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make

feature

	make is 
		do 
			print (x.item); io.new_line
			print (x.code); io.new_line
			print (x.hash_code); io.new_line
			print (x); io.new_line
			print (x < x); io.new_line
			print (x <= x); io.new_line
			print (x > x); io.new_line
			print (x >= x); io.new_line
			print (x = x); io.new_line
			print (x /= x); io.new_line
			print (x.is_equal (x)); io.new_line
			print (x.max (x)); io.new_line
			print (x.min (x)); io.new_line
			print (x.three_way_comparison (x)); io.new_line
		end

	x: WIDE_CHARACTER

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.


class TEST

create
	make
feature
	make is
		do
			print (Value1); io.new_line
			print (Value2); io.new_line
		end

	Value1: DOUBLE is 5_000_000.5
	Value2: INTEGER is 5_000_000

end

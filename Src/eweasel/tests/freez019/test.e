
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
			i8: INTEGER_8
			i16: INTEGER_16
			i: INTEGER
		do
			i8 := 0x7F
			i16 := 0x7FFF
			print (<< i16 + i8, i >> @ 1); io.new_line
			print (i16 + i8); io.new_line
		end

end

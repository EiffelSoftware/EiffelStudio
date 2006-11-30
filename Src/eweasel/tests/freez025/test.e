
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	TEST

create
	make

feature 

	make is
		local
			l_i16: INTEGER_16
		do
			l_i16 := -511
			if (l_i16 & 0xFF00) = 0xFE00 then
				print ("Ok%N")
			else
				print ("Not ok%N")
			end
		end
end

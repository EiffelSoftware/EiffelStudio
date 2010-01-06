
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
			print (0xD); io.new_line
			print (- 0xD); io.new_line
			print (value1); io.new_line
			print (value2); io.new_line
		end
	
	value1: INTEGER is 0xD
	value2: INTEGER is -0xD
end

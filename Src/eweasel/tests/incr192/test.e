
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
			print (value1); io.new_line
			print (value2); io.new_line
			print (value3); io.new_line
		end;
		

	value1: BOOLEAN is $VAL1
	value2: REAL is    $VAL2
	value3: DOUBLE is  $VAL3
end

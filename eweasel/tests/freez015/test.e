
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make
		do 
			create x 
			create y
			io.put_boolean (x.address = y.address); io.new_line
			io.put_boolean (y.address = y.new_address); io.new_line
  		end
			
	x: TEST1
	y: TEST2
			
end


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
			!!x.make
			print (x.s.value1); io.new_line
			print (x.s.value2); io.new_line
		end

	
	x: TEST1 [TEST3]
end

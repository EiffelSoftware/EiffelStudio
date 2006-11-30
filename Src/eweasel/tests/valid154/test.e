
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
			y: ARRAY [NONE]
		do
			create y.make (1, 2)
			y.put (Void, 1)
			y.put (Void, 2)
			x := y
			print (x.array.item (2) = Void); io.new_line
		end
	
	x: TEST1
end

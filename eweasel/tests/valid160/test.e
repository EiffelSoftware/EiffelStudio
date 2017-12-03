
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
			create x.make_filled (0.0, 1, 3)
			create y.make_filled (Void, 1, 3)
			x := y
			print (x.generating_type); io.new_line
			print (x.item (1)); io.new_line
			print (x.item (1).generating_type); io.new_line
		end

	x: ARRAY [DOUBLE]
	y: ARRAY [NONE]

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature

	make is
		local
			y: TEST1
		do
			!!x
			y := (x).item
			print (y.val); io.new_line
			y := @ x
			print (y.val); io.new_line
		end

	x: TEST1
end

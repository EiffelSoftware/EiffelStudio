
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature

	make
		local
			y: TEST1
		do 
			create x
			y := (x).item
			print (y.val); io.new_line
			y := @ x
			print (y.val); io.new_line
		end

	x: TEST1
end

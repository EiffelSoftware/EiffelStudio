
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
			a: ANY
		do
			a := x
			t (Void, Void, Void)
		end
			
	w: STRING

	z: TEST2 [like w, like w]

	x: like z

	t (a: like b; b: TEST2 [like c, like c]; c: TEST) is
		do
		end

end

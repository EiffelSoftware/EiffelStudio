
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
			a: TEST1
			b: expanded TEST1
			c: TEST2
			d: expanded TEST2
		do
			a := a
			a := b
			a := c
			a := d
			-- b := a
			b := b
			$INSTRUCTION
		end;
		

end

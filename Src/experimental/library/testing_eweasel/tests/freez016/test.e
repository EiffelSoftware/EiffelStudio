
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
			!!x
			x.weasel
			io.put_string (x.w.generating_type); io.new_line
			!!y
			y.weasel
			io.put_string (y.w.generating_type); io.new_line
			!!z
			z.weasel
			io.put_string (z.w.generating_type); io.new_line
			!!k
			k.weasel
			io.put_string (k.w.generating_type); io.new_line
		end;
	
	x: TEST1 [INTEGER_8]
	y: TEST1 [INTEGER_16]
	z: TEST1 [INTEGER]
	k: TEST1 [INTEGER_64]
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
inherit
	TEST2 [TEST4]
		rename
			x as y
		redefine
			f
		select
			y
		end
	TEST2 [$TEST3]
		redefine
			f
		end
creation
	make
feature
	make is
		do
			!!d1.make
			!!d2.make
			d2 := f
			io.put_string (d2.generating_type) io.new_line
			io.put_integer (d2.www); io.new_line
		end

	f: TEST4 is
		do
			io.put_string ("In TEST1 f%N")
			d1 := precursor
			d2 := precursor
			Result := precursor
		end

	d1: TEST3

	d2: TEST4

end

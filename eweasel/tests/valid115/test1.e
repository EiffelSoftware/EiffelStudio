
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
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
create
	make
feature
	make
		do
			create d1.make
			create d2.make
			d2 := f
			io.put_string (d2.generating_type.name_32.to_string_8) io.new_line
			io.put_integer (d2.www); io.new_line
		end

	f: TEST4
		do
			io.put_string ("In TEST1 f%N")
			d1 := precursor
			d2 := precursor
			Result := precursor
		end

	d1: TEST3

	d2: TEST4

end

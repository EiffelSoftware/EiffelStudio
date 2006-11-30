
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
			x: TEST2 [STRING]
			a: ARRAY [STRING]
		do
			create x
			a := x.new_array
			print (a.generating_type)
			print ("%N")
			print (a.area.generating_type)
			print ("%N")
		end

end

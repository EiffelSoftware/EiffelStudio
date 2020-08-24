
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	TEST2
		redefine
			make
		end
create
	make
feature
	make
		do
			io.put_string ("In TEST3 make%N")
		end

	value1: DOUBLE = 3.14
	
	value2: DOUBLE
end


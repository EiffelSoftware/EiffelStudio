
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST4
inherit
	TEST3
		redefine
			make
		end
create
	make
feature
	make
		do
			io.put_string ("In TEST4 make%N")
		end
	
	www: INTEGER
end

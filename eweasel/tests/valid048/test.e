--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit

	TEST2
		redefine
			d
		end

create
	make

feature
	
	make
		do
		end
	
	d: INTEGER
		do
		end

end

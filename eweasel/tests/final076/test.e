
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature

	make
		local
			x: TEST3
		do
			create x
			io.put_string (x.s.as_lower); io.new_line
		end

end

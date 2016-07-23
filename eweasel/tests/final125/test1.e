
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [H, G]

create
	make

feature

	make (s: H)
		do
			data := s
		end

	data: H

	f (a, b: H; c: G)
		do
			if (a /= data) or (b /= data) then
				io.put_string ("Not OK!")
				io.put_new_line
			end
		end

end

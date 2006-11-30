
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
			k, x: INTEGER_64
		do
			x := 1
			from
				k := 0
			until
				k >= 63
			loop
				print (x); io.new_line
				x := 2 * x
				k := k + 1
			end
		end;

end

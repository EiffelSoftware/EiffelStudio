
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
			k: INTEGER;
			t: TEST1
		do
			from
				k := 1;
			until
				k > 100000
			loop
				io.putstring ("Creating instance of TEST1: ");
				io.putint (k); io.new_line;
				!!t;
				k := k + 1;
			end
		end

end

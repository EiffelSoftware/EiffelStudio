
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	TEST
create
	make
feature
	make is
		local
			t: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER,
INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]
			k: INTEGER
		do
			from
				k := 1
			until
				k > 10000
			loop
				create t
				k := k + 1
			end
		end
end

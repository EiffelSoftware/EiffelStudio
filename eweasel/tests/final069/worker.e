
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD
		rename
			make as thread_make
		end
create
	make

feature

	make (n, s: INTEGER)
		do
			thread_make
			iterations := n
			size := s
		end;

	execute is
		local
			k: INTEGER
			s: SPECIAL [TEST2]
			t: TEST2
		do
			from
				k := 1
			until
				k > iterations
			loop
				create s.make_filled (t, size)
				k := k + 1
			end
		end;

	size: INTEGER

	iterations: INTEGER

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD

create
	make

feature

	make (n, s: INTEGER)
		do
			iterations := n
			size := s
		end;

	execute is
		local
			k: INTEGER
			s: SPECIAL [TEST2]
		do
			from
				k := 1
			until
				k > iterations
			loop
				create s.make (size)
				k := k + 1
			end
		end;

	size: INTEGER

	iterations: INTEGER

end

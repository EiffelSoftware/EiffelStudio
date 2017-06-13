--| Copyright (c) 1993-2017 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TESTER [G -> ANY create default_create end]

feature

	x: detachable G -- 0: creation invariant
	
	test
		local
			t: G
				-- 1: creation invariant
			s: SPECIAL [G]
		do
				-- 2: creation invariant
			io.put_string ("2: ")
			create t
				-- 3: invariant invariant
			io.put_string ("3: ")
			t.do_nothing
				-- 4: creation invariant
			io.put_string ("4: ")
			create x
				-- 5: creation invariant creation invariant
			io.put_string ("5: ")
			create s.make_empty (2)
			s.do_nothing
		end

end

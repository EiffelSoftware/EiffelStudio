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
			create t
			t.do_nothing
			create s.make_empty (2)
			s.do_nothing
		end

end

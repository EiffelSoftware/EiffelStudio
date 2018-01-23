--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit	
	SHARED

create
	make

feature

	make
		do
			Current.weasel
		end
	
	weasel is
		require
			pre: show ("Precondition")
		external "C"
			alias "eif_gc_run"
		ensure
			post1: show ("Postcondition")
			post2: (0).equal (True, old show ("Old expression"))
		end
		
invariant
	inv1: show ("Invariant")

end

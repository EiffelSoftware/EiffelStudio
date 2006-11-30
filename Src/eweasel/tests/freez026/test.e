
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create

	make

feature

	make is
		do
			test_like_argument ("STRING")
			test_like_argument (<<1>>)
		end

	test_like_argument (arg: ANY) is
		local
			t: LINKED_LIST [like arg]
		do
			create t.make
			print (t.generating_type)
			print ("%N")
		end

end

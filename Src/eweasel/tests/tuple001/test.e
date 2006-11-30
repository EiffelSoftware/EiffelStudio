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
			test_simple_content
			test_comparison
		end

	test_simple_content is
		local 
			t: TUPLE [BOOLEAN, INTEGER, STRING]
		do 
			t  := [False, 342, "Bzttt!"]
			check t.count = 3 end

			check equal (t.item(1), False) end
			check t.item (1).is_equal (False) end
			check t.is_boolean_item (1) end
			check t.boolean_item (1) = False end

			check equal (t @ 2, 342) end
			check (t @ 2).is_equal(342) end
			check t.is_integer_item (2) end
			check t.integer_item (2) = 342 end
			check (t @ 2) = 342 end

			check equal (t @ 3, "Bzttt!") end
			check (t @ 3).is_equal("Bzttt!") end
		end

	test_comparison is
		do
			check not ([1] = [1]) end
			check equal ([1], [1]) end
		end

end

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
		end

	test_simple_content is
		local 
			t: TUPLE [
				$FIRST_NAME: BOOLEAN;
				$SECOND_NAME: INTEGER;
				$THIRD_NAME: STRING
				]
		do 
			t  := [False, 342, "Bzttt!"]
			check t.count = 3 end

			check equal (t.$FIRST_NAME, False) end
			check t.$FIRST_NAME.is_equal (False) end
			check t.is_boolean_item (1) end
			check t.$FIRST_NAME = False end

			check equal (t.$SECOND_NAME, 342) end
			check (t.$SECOND_NAME).is_equal(342) end
			check t.is_integer_item (2) end
			check t.$SECOND_NAME = 342 end

			check equal (t.$THIRD_NAME, "Bzttt!") end
			check (t.$THIRD_NAME).is_equal("Bzttt!") end
		end

end

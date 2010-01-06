
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
			-- 
		do
			test_integer_8
			test_integer_16
			test_integer_32
			test_integer_64
			test_natural_8
			test_natural_16
			test_natural_32
			test_natural_64
		end
		
feature 

	test_integer_8 is
		local
			i: INTEGER_8
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_integer_8 |<< j)) /= 0)
			verify (i.bit_test (j))
		end
		
	test_integer_16 is
		local
			i: INTEGER_16
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_integer_16 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	test_integer_32 is
		local
			i: INTEGER
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & (1 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	test_integer_64 is
		local
			i: INTEGER_64
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_integer_64 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	test_natural_8 is
		local
			i: NATURAL_8
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_natural_8 |<< j)) /= 0)
			verify (i.bit_test (j))
		end
		
	test_natural_16 is
		local
			i: NATURAL_16
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_natural_16 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	test_natural_32 is
		local
			i: NATURAL_32
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_natural_32 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	test_natural_64 is
		local
			i: NATURAL_64
			j: INTEGER
		do
			i := 8
			j := 3
			verify ((i & ((1).to_natural_64 |<< j)) /= 0)
			verify (i.bit_test (j))
		end

	verify (b: BOOLEAN) is
		do
			if not b then
				io.put_string ("Error%N")
			end
		end
		

end

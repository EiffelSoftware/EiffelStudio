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
			t: TUPLE [a: BOOLEAN; b: INTEGER; c: STRING]
		do 
			create t
			t.c := "s"
			if ("s").is_equal (t.c) then
				print ("OK%N")
			end
		end

end

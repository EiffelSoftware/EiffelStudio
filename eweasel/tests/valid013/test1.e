
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST1
feature
	test_me
		local
			x: TEST1;
		do 
			create x;
			x.set_attribute_field (Current);
			attribute_field := x;
		end;

	attribute_field: like Current;
	
	set_attribute_field (arg: like Current)
		do
			attribute_field := arg;
		end
	

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST1
feature
	test_me is
		local
			x: TEST1;
		do
			!!x;
			x.set_attribute_field (Current);
			attribute_field := x;
		end;

	attribute_field: like Current;
	
	set_attribute_field (arg: like Current) is
		do
			attribute_field := arg;
		end
	

end

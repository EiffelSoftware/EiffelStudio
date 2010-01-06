
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

-- To reproduce error:
-- 	Compile classes as is.  Compiler reports violation of constraint
--	VMRC, even though there is only one potential version of `my_feature'
--	in class TEST.

class TEST
inherit
	TEST1
		rename 
			my_feature as my_feature1 
		end;
	TEST1
		rename 
			my_feature as my_feature2 
		end;
feature

	make is
		do
			my_feature1;
			my_feature2;
		end;

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
feature	
	exp_test1: expanded TEST1;

	test1_ref: TEST1 is
		do
			Result := exp_test1.self_ref;
		end

end

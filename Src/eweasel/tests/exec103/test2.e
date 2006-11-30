
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
feature
	weasel (arg: TEST1) is
		do
			arg.set_value (13);
		end
end

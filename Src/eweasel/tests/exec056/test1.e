
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	SHOW
feature
	weasel is
		require
			test1_precond: show ("TEST1 precondition", False);
		do
		ensure
			test1_postcond: show ("TEST1 postcondition", True);
		end
end

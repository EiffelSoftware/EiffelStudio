
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST2
inherit
	SHARED
feature
	weasel is
		deferred
		ensure
			parent_post4: show ("Postcondition 7");
			parent_post5: show ("Postcondition 8");
			parent_post6: show ("Postcondition 9");
		end
end

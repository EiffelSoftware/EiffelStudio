
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST1
inherit
	SHARED
feature
	weasel is
		deferred
		ensure
			parent_post1: show ("Postcondition 4");
			parent_post2: show ("Postcondition 5");
			parent_post3: show ("Postcondition 6");
		end
end

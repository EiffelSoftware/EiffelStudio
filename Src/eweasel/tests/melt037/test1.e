
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
			parent_post1: 
				old show ("Old expression 7") or
				old show ("Old expression 8") and
				old show ("Old expression 9") and
				old show ("Old expression 10");
			parent_post2: 
				old show ("Old expression 11") or
				old show ("Old expression 12");
		end
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST2
inherit
	SHOW
feature
	try1 is
		require
			assert: show ("Precondition of try1 in TEST2");
		deferred
		ensure
			assert: show ("Postcondition of try1 in TEST2");
		end

	try2 is
		require
			assert: show ("Precondition of try2 in TEST2");
		deferred
		ensure
			assert: show ("Postcondition of try2 in TEST2");
		end

	try3 is
		require
			assert: show ("Precondition of try3 in TEST2");
		deferred
		ensure
			assert: show ("Postcondition of try3 in TEST2");
		end

end

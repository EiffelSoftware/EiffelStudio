
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	TEST2 [STRING]
		rename
			wimp as turkey
		select
			turkey
		end
	TEST2 [DOUBLE];
feature
	weasel
		do
			wimp (2.5);
			turkey ("weasel");
		end
	
end

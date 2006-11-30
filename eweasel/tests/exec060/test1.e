
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
inherit
	ARRAY [expanded TEST2]
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		local
			-- gc: expanded MEMORY;
		do
			-- gc.collection_off;
			io.putstring ("Starting TEST1 creation proc%N");
			make (1, 100000);
			io.putstring ("Leaving TEST1 creation proc%N");
		end
end

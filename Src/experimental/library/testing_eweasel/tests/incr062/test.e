
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1;
	HASHABLE
feature

	make is
		external "C"
		alias "wimp"
		end

	hash_code: INTEGER is 1;
end


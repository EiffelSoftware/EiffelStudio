
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			io.put_string ("In TEST3 make%N")
		end

	to_reference: TEST3 is
		do
			create Result
		end
end

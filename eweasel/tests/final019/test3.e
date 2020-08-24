
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			io.put_string ("In TEST3 make%N")
		end

	to_reference: TEST3
		do
			create Result
		end
end

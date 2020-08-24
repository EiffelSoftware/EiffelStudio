
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	make, make1
feature
	make, make1 do end
	to_reference: TEST1
		do
			create Result.make
		end
end

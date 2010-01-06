
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G, ARRAY_TYPE -> ARRAY[G] create make end]

feature

	new_array: ARRAY_TYPE is
		do
			create Result.make (1, 3)
		end
		
end

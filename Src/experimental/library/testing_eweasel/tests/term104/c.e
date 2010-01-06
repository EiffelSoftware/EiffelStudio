
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	C [G]

feature
	
	item: G is
		do
		end
	
	f: LIST [C [G]] is
		do
			!ARRAYED_LIST [C [G]]!Result.make (1)
			Result.extend (Current)
		end
	
end

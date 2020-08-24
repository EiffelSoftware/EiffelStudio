
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	C [G]

feature
	
	item: G
		do
		end
	
	f: LIST [C [G]]
		do 
			create {ARRAYED_LIST [C [G]]} Result.make (1)
			Result.extend (Current)
		end
	
end

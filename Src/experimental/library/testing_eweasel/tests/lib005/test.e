
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			list1, list2: ARRAYED_LIST [INTEGER]
		do
			create list1.make (0)
			create list2.make (0)
			list1.append (list2)
		end
	
end

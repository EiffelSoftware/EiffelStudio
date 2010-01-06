
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		local
			item: SPECIAL [INTEGER]
		do
			create row_list.make_filled (Void, 10)
			row_list.put (create {SPECIAL [INTEGER]}.make_filled (0, 10), 1)
			item := row_list @ 1
			print (item.generating_type)
			io.new_line
		end;

	row_list: SPECIAL [detachable SPECIAL [INTEGER]]

end

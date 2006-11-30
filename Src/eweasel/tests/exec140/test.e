
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature

	make is
		do
			create x.make
			x.put ("1")
			x.put ("2")
			list := x.linear_representation
			from
				list.start
			until
				list.after
			loop
				print (list.item); io.new_line
				list.forth
			end
		end
			
	x: LINKED_QUEUE [STRING]
	
	list: LINEAR [STRING]
end

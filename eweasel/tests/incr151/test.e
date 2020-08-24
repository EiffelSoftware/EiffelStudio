
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make
feature 
	make (args: ARRAY [STRING])
		local
			k, count: INTEGER
			decompressor: DECOMPRESSOR
			list: ARRAYED_LIST [DECOMPRESSOR]
		do
			count := args.item (1).to_integer 
			create list.make (count)
			from 
				k := 1
			until 
				k > count
			loop 
				create decompressor.make
				list.extend (decompressor)
				decompressor.initialize
				k := k + 1
			end
		end

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature 
	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
			decompressor: DECOMPRESSOR
			list: ARRAYED_LIST [DECOMPRESSOR]
		do
			count := args.item (1).to_integer
			!!list.make (count)
			from 
				k := 1
			until 
				k > count
			loop
				!!decompressor.make
				list.extend (decompressor)
				decompressor.initialize
				k := k + 1
			end
		end

end

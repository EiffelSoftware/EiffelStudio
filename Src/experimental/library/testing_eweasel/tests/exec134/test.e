
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
			ht : HASH_TABLE [ANY, INTEGER]
		do 
			create ht.make (10)
			ht.extend (Current, 0)
			print (ht.item (0).generating_type); io.new_line
		end
	
end

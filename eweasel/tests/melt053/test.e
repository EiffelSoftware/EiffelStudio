
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is 
		do 
			item := 269
			print (item >= feature {CHARACTER}.Max_value)
			io.new_line
		end
	
	item: INTEGER
end

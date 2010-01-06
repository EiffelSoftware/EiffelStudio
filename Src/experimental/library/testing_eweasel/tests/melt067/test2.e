
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2 [G]
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create is
		do
			print ("In TEST2 make%N")
			print (generating_type); io.new_line
		end
	
end

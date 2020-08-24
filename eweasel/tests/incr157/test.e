
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make
		do 
			create x
  		end
			
	x: TEST1 [STRING, TEST2 [STRING, STRING, STRING], TEST2 [STRING, SEQ_STRING, TEST1 [STRING, STRING, STRING]]]
			
end

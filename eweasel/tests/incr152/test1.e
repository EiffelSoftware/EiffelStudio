
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2 create make end]

create
	make

feature

	make
		local
			x: G
		do
			io.put_string ("In TEST1 make%N") 
			create x.make
		end
	
end

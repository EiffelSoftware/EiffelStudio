
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2 create make end]
create
	make
feature
	make
		do 
			create {TEST2} s.make
		end

	s: G
end
